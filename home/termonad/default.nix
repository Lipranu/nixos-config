{
#  home-manager.users.lipranu.home.file.".config/termonad/termonad.hs".text
#    = builtins.readFile ./termonad.hs;
  home-manager.users.lipranu.xdg.configFile."termonad/termonad.hs".source
    = ./termonad.hs;
}
