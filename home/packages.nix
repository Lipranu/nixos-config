{ pkgs, ... }: {
  home-manager.users.lipranu.home.packages = with pkgs; [
  	ranger
  	xmobar
    termonad-with-packages
  ];
}
