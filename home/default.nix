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
