{ pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  home-manager.users.lipranu = rec {

    home = {
      
      homeDirectory = "/home/lipranu";
      stateVersion = "20.09";
      
      keyboard = {
        layout = "us,ru";
	options = ["ctrl:swapcaps" "grp:alt_shift_toogle"];
      };

      packages = with pkgs; [
        termonad-with-packages
      ];

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

    xsession = {
      enable = true;
      windowManager.xmonad.enable = true;
    };

    programs.git = {
      enable = true;
      userEmail = "lipranu@gmail.com";
      userName = "Igor Belousov";
    };

  };
}
