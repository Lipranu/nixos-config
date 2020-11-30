{ pkgs, ... }: {
  home-manager.users.lipranu.home.packages = with pkgs; [
  	ranger
  	xmobar
    ghostscript
    gnumake
    libreoffice
    tdesktop
    termonad-with-packages
    wget
  ];
}
