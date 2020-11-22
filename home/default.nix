{
  imports = [
    ./packages.nix
    ./picom.nix
    ./xmobar.nix
    (import ./emacs)
    (import ./neovim)
    (import ./ranger)
    (import ./termonad)
    (import ./xmonad)
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.lipranu = rec {

      home = {
        homeDirectory = "/home/lipranu";
        stateVersion = "20.09";

        keyboard = {
          layout = "us,ru";
  	      options = ["grp:alt_shift_toggle" "ctrl:swapcaps"];
        };

      };

      xdg = {
        dataHome = "${home.homeDirectory}/.local/share";
        configHome = "${home.homeDirectory}/.config";

        userDirs = {
          enable = true;
  	      documents = "${home.homeDirectory}/docs";
  	      download = "${home.homeDirectory}/dl";
  	      music = "${home.homeDirectory}/music";
  	      pictures = "${home.homeDirectory}/pics";
        };

      };

      systemd.user.startServices = true;

      services.random-background = {
        enable = true;
        imageDirectory = "${xdg.userDirs.pictures}/wallpapers";
      };

      xsession.enable = true;

      programs.zathura.enable = true;

    };
  };
}
