{
  imports = [
    ./chromium.nix
    ./direnv.nix
    ./firefox.nix
    ./git.nix
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
      systemd.user.startServices = true;

      xsession.enable = true;

      programs = {
        bash.enable = true;
        feh.enable = true;
        texlive.enable = true;
        zathura.enable = true;
      };

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

      services = {
        lorri.enable = true;
        random-background = {
          enable = true;
          imageDirectory = "${xdg.userDirs.pictures}/wallpapers";
        };
      };

    };
  };
}
