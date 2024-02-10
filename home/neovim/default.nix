{ pkgs, ... }: {
  home-manager.users.lipranu.programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
      enable = true;
      
      vimAlias = true;
      extraLuaConfig = builtins.readFile ./options.lua;

      extraPackages = with pkgs; [
        lua-language-server
        rnix-lsp
      ];

      plugins = with pkgs.vimPlugins; [
        lualine-nvim
        nvim-web-devicons
        neo-tree-nvim
	vim-nix
        vim-better-whitespace
        nvim-cmp
        {
          plugin = nvim-cmp;
          type = "lua";
          config = ./plugin/cmp.lua;
        }
        {
          plugin = gruvbox-nvim;
          config = "colorscheme gruvbox";
        }
        {
      	  plugin = lualine-nvim;
          type = "lua";
	  config = "require(\"lualine\").setup()";
        }
	{
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        type = "lua";
        config = ./plugin/treesitter.lua;
        }
      ];
  };
}
