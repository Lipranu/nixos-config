{
  home-manager.users.lipranu.home.file.".xmobarrc".text = ''
    Config  { font = "xft:Iosevka:weight=bold:size=10:antialias=true"
            , additionalFonts = []
            , borderColor = "#303035"
            , border = FullB
            , bgColor = "#222225"
            , fgColor = "#BABAC4"
            , alpha = 255
            , position = Top
            , textOffset = -1
            , iconOffset = -1
            , lowerOnStart = True
            , pickBroadest = False
            , persistent = True
            , hideOnStart = False
            , iconRoot = "."
            , allDesktops = True
            , overrideRedirect = True
            , commands =
              [ Run Cpu
                  [ "-t", "cpu <total> %"
                  , "-L", "20"
                  , "-H", "70"
                  , "-l", "#6FB593"
                  , "-n", "#DBAC66"
                  , "-h", "#CD5C60"
                  ] 10
              , Run Memory
                  [ "-t", "mem <usedratio> %"
                  , "-L", "20"
                  , "-H", "70"
                  , "-l", "#6FB593"
                  , "-n", "#DBAC66"
                  , "-h", "#CD5C60"
                  ] 10
              , Run Com "uname" [ "-n", "-r" ] "" 36000
              , Run Date "%d-%m-%Y %H-%M-%S" "date" 10
              , Run DiskU [("/", "ssd <freep> %")]
                  [ "-L", "25"
                  , "-H", "50"
                  , "-l", "#CD5C60"
                  , "-n", "#DBAC66"
                  , "-h", "#6FB593"
                  ] 20
              , Run Kbd [("us", "EN"), ("ru", "RU")]
              , Run StdinReader
              ]
            , sepChar = "%"
            , alignSep = "}{"
            , template =
                "%StdinReader% }{ \
                \ <fc=#303035>|</fc> <fc=#9D81BA>%kbd%</fc>\
                \ <fc=#303035>|</fc> %cpu%\
                \ <fc=#303035>|</fc> %memory%\
                \ <fc=#303035>|</fc> %disku%\
                \ <fc=#303035>|</fc> <fc=#80BCB6>%date%</fc>\
                \ <fc=#303035>|</fc> %uname% "
            }
  '';
}
