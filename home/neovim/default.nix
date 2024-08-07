{ pkgs, ... }: {
  home-manager.users.lipranu.programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraLuaConfig = builtins.readFile ./options.lua;

      extraPackages = with pkgs; [
        lua-language-server
      ];

      plugins = with pkgs.vimPlugins; [
        cmp-nvim-lsp
        cmp_luasnip
        dhall-vim
        haskell-tools-nvim
        haskell-vim
        lualine-nvim
        luasnip
        nvim-web-devicons
        purescript-vim
        telescope-fzf-native-nvim
        vim-better-whitespace
        vim-nix
        which-key-nvim
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ./plugin/lsp.lua;
        }
        {
          plugin = nvim-cmp;
          type = "lua";
          config = builtins.readFile ./plugin/cmp.lua;
        }
        {
          plugin = onedark-nvim;
          type = "lua";
          config = builtins.readFile ./plugin/onedark.lua;
        }
        {
          plugin = neo-tree-nvim;
          type = "lua";
          config = builtins.readFile ./plugin/neo-tree.lua;
        }
        {
      	  plugin = lualine-nvim;
          type = "lua";
          config = "require(\"lualine\").setup()";
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile ./plugin/telescope.lua;
        }
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = "require(\"ibl\").setup()";
        }
        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-bash
            p.tree-sitter-dhall
            p.tree-sitter-haskell
            p.tree-sitter-json
            p.tree-sitter-lua
            p.tree-sitter-nix
            p.tree-sitter-purescript
            p.tree-sitter-python
            p.tree-sitter-vim
            p.tree-sitter-vimdoc
          ]));
          type = "lua";
          config = builtins.readFile ./plugin/treesitter.lua;
        }
      ];
  };
}
