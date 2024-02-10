{
  home-manager.users.lipranu.programs.alacritty = {
    enable = true;
    settings = {

      font = rec {
        normal.family = "Iosevka";
        size = 11;
        bold = { style = "Bold"; };
      };
    };
  };
}
