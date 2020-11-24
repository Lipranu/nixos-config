{ pkgs, ... }: {
  home-manager.users.lipranu.home.packages = with pkgs; [
  	ranger
  	xmobar
    gnumake
    libreoffice
    tdesktop
    termonad-with-packages
    wget
  ];
}
