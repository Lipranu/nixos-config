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

    };

    programs.git = {
      enable = true;
      userEmail = "lipranu@gmail.com";
      userName = "Igor Belousov";
    };

  };
}
