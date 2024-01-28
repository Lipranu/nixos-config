{ pkgs, ... }:
{
  home-manager.users.lipranu.programs.vscode = {
    enable = true;
#    userSettings = {
#      "[nix]"."editor.tabSize" = 2;
#      "[haskell]"."editor.tabSize" = 2;
#      "[scala]"."editor.tabSize" = 2;
#    };

    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      bbenoist.nix
      haskell.haskell
      justusadam.language-haskell
      #ms-vscode-remote.vscode-remote-extensionpack
#      ms-vscode.remote-server
      rust-lang.rust-analyzer
      scala-lang.scala
      scalameta.metals
      vscodevim.vim
    ];
  };
}
