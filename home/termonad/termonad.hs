{-# LANGUAGE OverloadedStrings #-}

module Main where

import Termonad.App           ( defaultMain )
import Termonad.Config        ( ConfigOptions (..)
                              , FontConfig (..)
                              , FontSize (..)
                              , Option (..)
                              , ShowScrollbar (..)
                              , TMConfig (..)
                              , defaultConfigOptions
                              , defaultTMConfig
                              )
import Termonad.Config.Colour ( AlphaColour
                              , ColourConfig (..)
                              , Palette (..)
                              , addColourExtension
                              , createColour
                              , createColourExtension
                              , defaultLightColours
                              , mkList8
                              )
import Data.Maybe             ( fromMaybe )

myCursorColour, myForegroundColour, myBackgroundColour :: AlphaColour Double
myCursorColour     = createColour 239 239 241
myForegroundColour = createColour 228 228 232
myBackgroundColour = createColour 24  24  27

myColourConfig :: ColourConfig (AlphaColour Double)
myColourConfig = ColourConfig
  { cursorBgColour   = Set myCursorColour
  , cursorFgColour   = Set myBackgroundColour
  , backgroundColour = Set myBackgroundColour
  , foregroundColour = Set myForegroundColour
  , palette          = mkColours
  }

mkColours :: Palette (AlphaColour Double)
mkColours = BasicPalette . fromMaybe defaultLightColours $ mkList8
  [ myBackgroundColour
  , createColour 205 92  96
  , createColour 111 181 147
  , createColour 219 172 102
  , createColour 77  147 145
  , createColour 157 129 186
  , createColour 107 217 219
  , myForegroundColour
  ]

myFontConfig :: FontConfig
myFontConfig = FontConfig
  { fontFamily = "Iosevka"
  , fontSize   = FontSizePoints 13
  }

myOptionsConfig :: ConfigOptions
myOptionsConfig  = defaultConfigOptions
  { fontConfig    = myFontConfig
  , showScrollbar = ShowScrollbarAlways
  , confirmExit   = False
  , showMenu      = False
  , boldIsBright  = False
  }

myTMConfig :: TMConfig
myTMConfig = defaultTMConfig { options = myOptionsConfig }

main :: IO ()
main = createColourExtension myColourConfig
   >>= defaultMain . addColourExtension myTMConfig
