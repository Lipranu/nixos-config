{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.lipranu.programs.git = {
    enable = true;
    userEmail = "lipranu@gmail.com";
    userName = "Igor Belousov";
  };
}
