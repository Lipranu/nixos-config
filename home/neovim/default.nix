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
        rnix-lsp
      ];

      plugins = with pkgs.vimPlugins; [
        lualine-nvim
        nvim-web-devicons
        vim-nix
        vim-better-whitespace
        luasnip
        haskell-vim
        haskell-tools-nvim
        cmp_luasnip
        cmp-nvim-lsp
        telescope-fzf-native-nvim
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
          plugin = gruvbox-nvim;
          config = "colorscheme gruvbox";
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
          plugin = (nvim-treesitter.withPlugins (p: [
            #TODO: deal with tree-sitter for haskell
            #p.tree-sitter-haskell
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
          ]));
          type = "lua";
          config = builtins.readFile ./plugin/treesitter.lua;
        }
      ];
  };
}
