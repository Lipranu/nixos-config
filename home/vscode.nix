{ pkgs, ... }:
{
  home-manager.users.lipranu.programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };
}
