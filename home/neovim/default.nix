{ pkgs, ... }: {
  home-manager.users.lipranu.programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = with pkgs.vimPlugins; [
      ayu-vim
      haskell-vim
      lightline-vim
      nerdtree
      nerdtree-git-plugin
      ultisnips
      vim-hindent
      vim-nix
      vimtex
    ];
  };
}
