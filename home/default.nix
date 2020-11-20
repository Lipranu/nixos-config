{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  home-manager.users.lipranu = rec {

    home.homeDirectory = "/home/lipranu";

    programs.git = {
      enable = true;
      userEmail = "lipranu@gmail.com";
      userName = "Igor Belousov";
    };

  };
}
