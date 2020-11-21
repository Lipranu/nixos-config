{ pkgs, ... }:
{
  imports = [
   ./xmobar.nix
   ./picom.nix
   (import ./termonad)
   (import ./xmonad)
   (import ./emacs)
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  home-manager.users.lipranu = rec {

    home = {
      
      homeDirectory = "/home/lipranu";
      stateVersion = "20.09";
      
      keyboard = {
        layout = "us,ru";
	options = ["grp:alt_shift_toggle" "ctrl:swapcaps"];
      };

      packages = with pkgs; [
        termonad-with-packages
	xmobar
	ranger
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

    services.random-background = {
      enable = true;
      imageDirectory = "${xdg.userDirs.pictures}/wallpapers";
    };

    xsession = {
      enable = true;
    };

    programs.zathura.enable = true;
    programs.git = {
      enable = true;
      userEmail = "lipranu@gmail.com";
      userName = "Igor Belousov";
    };

  };
}
