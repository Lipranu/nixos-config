{ pkgs, ... }:
let
  crawl = pkgs.crawl.override { tileMode = true; };
in
{
  home-manager.users.lipranu.home.packages = with pkgs; [
    cachix
    cmake
    crawl
    dhall-lsp-server
    freemind
    gcc
    ghostscript
    gimp
    gnumake
    imagemagick
    libreoffice
    lua-language-server
    obsidian
    ranger
    ripgrep
    skypeforlinux
    sops
    tdesktop
    termonad
    tree-sitter
    unetbootin
    unrar
    unzip
    wget
    xclip
    xmobar
    zotero
#    steam
#    termonad-with-packages
  ];
}
