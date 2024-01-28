{ pkgs, ... }:
let
  crawl = pkgs.crawl.override { tileMode = true; };
in
{
  home-manager.users.lipranu.home.packages = with pkgs; [
    cachix
    crawl
    freemind
    ghostscript
    gnumake
    imagemagick
    libreoffice
    ranger
    skypeforlinux
#    steam
    tdesktop
#    termonad-with-packages
    termonad
    unetbootin
    unrar
    unzip
    wget
    xmobar
    obsidian
    zotero
    lua-language-server
  ];
}
