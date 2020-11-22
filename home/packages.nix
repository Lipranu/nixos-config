{ pkgs, ... }: {
  home-manager.users.lipranu.home.packages = with pkgs; [
  	ranger
  	xmobar
    gnumake
    tdesktop
    termonad-with-packages
    wget
  ];
}
