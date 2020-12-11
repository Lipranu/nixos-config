{ pkgs, ... }: {
  home-manager.users.lipranu.home.packages = with pkgs; [
    cachix
    ghostscript
    gnumake
    imagemagick
    libreoffice
    ranger
    tdesktop
    termonad-with-packages
    unetbootin
    unrar
    unzip
    wget
    xmobar
  ];
}
