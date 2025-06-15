{ pkgs, ... }: {
  fonts = {
    fontconfig.enable = true;
    fontconfig.defaultFonts.monospace = ["Iosevka"];
    fontDir.enable = true;
    packages = with pkgs; [
      #      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      nerd-fonts.iosevka
      dejavu_fonts
      emacs-all-the-icons-fonts
#      emojione
      fantasque-sans-mono
      fira-code
      font-awesome
      google-fonts
      hack-font
      hasklig
      iosevka
      material-icons
      noto-fonts-emoji
      powerline-fonts
    ];
  };
}
