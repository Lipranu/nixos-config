{
  home-manager.users.lipranu = {

    home.file.".emacs.d/init.el".source = ./init.el;

    programs.emacs = {
      enable = true;
      extraPackages = epkgs: with epkgs; [
        all-the-icons
        company
        company-nixos-options
        doom-modeline
        elm-mode
        erlang
        evil
#        evil-magit
        haskell-mode
        helm
        helm-nixos-options
        kaolin-themes
        magit
        nix-mode
        nixos-options
        projectile
        proofgeneral
        pdf-tools
        treemacs
        treemacs-evil
        treemacs-magit
        treemacs-projectile
        use-package
        which-key
        winum
      ];
    };

  };
}
