module Main where

----------------------------------------------------------------------------
-- IMPORTS -----------------------------------------------------------------
----------------------------------------------------------------------------

import XMonad
import XMonad.Hooks.EwmhDesktops    ( fullscreenEventHook )
import XMonad.Layout.LayoutModifier ( ModifiedLayout )
import XMonad.Hooks.DynamicLog      ( PP (..)
                                    , dynamicLogWithPP
                                    , wrap
                                    , pad
                                    , xmobarPP
                                    , xmobarColor
                                    , shorten
                                    )
import XMonad.Prompt                ( XPConfig (..), XPPosition (..) )
import XMonad.Prompt.Shell          ( shellPrompt )
import XMonad.Prompt.FuzzyMatch     ( fuzzyMatch )
import XMonad.Hooks.FadeInactive    ( fadeOutLogHook
                                    , isUnfocused
                                    , isUnfocusedOnCurrentWS
                                    )
import XMonad.Hooks.ManageDocks     ( AvoidStruts (..), avoidStruts, docks )
import XMonad.Util.Run              ( spawnPipe, hPutStrLn )
import XMonad.Util.SpawnOnce        ( spawnOnce )

import Data.Monoid
import Data.Bool                    ( bool )
import Data.Functor                 ( (<&>) )
import System.Exit
import GHC.IO.Handle.Types          ( Handle )

import qualified XMonad.StackSet as Stack
import qualified Data.Map        as Map

myForegroundColor  = "#BABAC4"
myBackgroundColor  = "#222225"
--mySelectionColor   = "#EFEFF1"
myBorderColor      = "#303035"
mySuccessColor     = "#6FB593"
myWarningColor     = "#DBAC66"
myFailureColor     = "#CD5C60"
myInformationColor = "#80BCB6"
myUnregularColor   = "#9D81BA"

myTerminal :: String
myTerminal = "termonad"

myFont = "xft:Iosevka:weight=bold:size=10:antialias=true"

myFocusFollowsMouse, myClickJustFocuses :: Bool
myFocusFollowsMouse = True
myClickJustFocuses  = False

myBorderWidth :: Dimension
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask :: KeyMask
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces :: [String]
myWorkspaces =
  [ "code"
  , "web"
  , "doc"
  , "chat"
  , "gimp"
  , "vbox"
  , "dir"
  , "mus"
  , "sys"
  ]

----------------------------------------------------------------------------
-- PROMPT ------------------------------------------------------------------
----------------------------------------------------------------------------

myXPConfig :: XPConfig
myXPConfig = def
  { font                = myFont
  , bgColor             = myBackgroundColor
  , fgColor             = myForegroundColor
  , bgHLight            = myBackgroundColor
  , fgHLight            = mySuccessColor
  , borderColor         = myBorderColor
  , promptBorderWidth   = 1
--  , promptKeymap        =
  , position            = Bottom
  , height              = 20
  , historySize         = 256
  , historyFilter       = id
  , autoComplete        = Nothing
  , showCompletionOnTab = True
  , searchPredicate     = fuzzyMatch
  , alwaysHighlight     = False
  , maxComplRows        = Just 5
  }

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = Map.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- prompt
    , ((modm,               xK_f     ), shellPrompt myXPConfig)

    -- launch emacs
    , ((modm,               xK_e     ), spawn "emacs")

    -- launch vim
    , ((modm,               xK_v     ), spawn "vim")

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows Stack.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows Stack.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows Stack.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows Stack.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows Stack.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows Stack.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows Stack.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . Stack.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(Stack.greedyView, 0), (Stack.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(Stack.view, 0), (Stack.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = Map.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows Stack.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows Stack.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows Stack.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
type MyLayout = ModifiedLayout
  AvoidStruts
  (Choose Tall (Choose (Mirror Tall) Full))

myLayout :: MyLayout a
myLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook :: Event -> X All
myEventHook = fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: X ()
myLogHook = fadeOutLogHook $ isUnfocusedOnCurrentWS <||> isUnfocused
  <&> bool 1 0.8

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = pure ()--do
--  spawnOnce "xcompmgr -cCfF &"
--  spawnOnce "feh --bg-fill --no-fehbg ~/.wallpaper &"

------------------------------------------------------------------------

main = spawnPipe "xmobar"
   >>= xmonad . docks . myXmonad

myXmonad :: Handle -> XConfig MyLayout
myXmonad xmproc = def
  { terminal           = myTerminal
  , focusFollowsMouse  = myFocusFollowsMouse
  , clickJustFocuses   = myClickJustFocuses
  , borderWidth        = myBorderWidth
  , modMask            = myModMask
  , workspaces         = myWorkspaces
  , normalBorderColor  = myBorderColor
  , focusedBorderColor = myBorderColor

    -- key bindings
  , keys               = myKeys
  , mouseBindings      = myMouseBindings

    -- hooks, layouts
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , handleEventHook    = myEventHook
  , logHook            = myLogHook <+> myXmobar xmproc
  , startupHook        = myStartupHook
  }

myXmobar xmproc = dynamicLogWithPP xmobarPP
  { ppCurrent         = xmobarColor mySuccessColor "" . pad
  , ppHidden          = xmobarColor myWarningColor "" . pad
  , ppHiddenNoWindows = xmobarColor myFailureColor "" . pad
  , ppLayout          = xmobarColor myUnregularColor "" . pad
  , ppOutput          = \x -> hPutStrLn xmproc x
  , ppSep             = xmobarColor myBorderColor "" "|"
  , ppTitle           = xmobarColor myInformationColor "" . pad . shorten 40
  , ppWsSep           = xmobarColor myBorderColor "" "|"
  , ppExtras          = [windowCount]
  , ppOrder           = \(ws:l:t:ex) -> [ws] <> ex <> [l, t]
  }

windowCount :: X (Maybe String)
windowCount = gets
  $ Just
  . pad
  . show
  . length
  . Stack.integrate'
  . Stack.stack
  . Stack.workspace
  . Stack.current
  . windowset

help :: String
help = unlines
  [ "The default modifier key is 'alt'. Default keybindings:"
  , ""
  , "-- launching and killing programs"
  , "mod-Shift-Enter  Launch termonad"
  , "mod-f            Launch prompt"
  , "mod-Shift-p      Launch gmrun"
  , "mod-Shift-c      Close/kill the focused window"
  , "mod-Space        Rotate through the available layout algorithms"
  , "mod-Shift-Space  Reset the layouts on the current workSpace to default"
  , "mod-n            Resize/refresh viewed windows to the correct size"
  , ""
  , "-- move focus up or down the window stack"
  , "mod-Tab        Move focus to the next window"
  , "mod-Shift-Tab  Move focus to the previous window"
  , "mod-j          Move focus to the next window"
  , "mod-k          Move focus to the previous window"
  , "mod-m          Move focus to the master window"
  , ""
  , "-- modifying the window order"
  , "mod-Return   Swap the focused window and the master window"
  , "mod-Shift-j  Swap the focused window with the next window"
  , "mod-Shift-k  Swap the focused window with the previous window"
  , ""
  , "-- resizing the master/slave ratio"
  , "mod-h  Shrink the master area"
  , "mod-l  Expand the master area"
  , ""
  , "-- floating layer support"
  , "mod-t  Push window back into tiling; unfloat and re-tile it"
  , ""
  , "-- increase or decrease number of windows in the master area"
  , "mod-comma  (mod-,)  Increment the number of windows in the master area"
  , "mod-period (mod-.)  Deincrement the number of windows in the master area"
  , ""
  , "-- quit, or restart"
  , "mod-Shift-q  Quit xmonad"
  , "mod-q        Restart xmonad"
  , "mod-[1..9]   Switch to workSpace N"
  , ""
  , "-- Workspaces & screens"
  , "mod-Shift-[1..9]   Move client to workspace N"
  , "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3"
  , "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3"
  , ""
  , "-- Mouse bindings: default actions bound to mouse events"
  , "mod-button1  Set the window to floating mode and move by dragging"
  , "mod-button2  Raise the window to the top of the stack"
  , "mod-button3  Set the window to floating mode and resize by dragging"
  ]
