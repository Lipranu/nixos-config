{ pkgs, ... }: {
  home-manager.users.lipranu.home.packages = with pkgs; [
    ghostscript
    gnumake
    imagemagick
    libreoffice
    ranger
    tdesktop
    termonad-with-packages
    unzip
    wget
    xmobar
  ];
}
