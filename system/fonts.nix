{ pkgs, ... }: {
  fonts = {
    fontconfig.defaultFonts.monospace = ["Iosevka"];
    fontDir.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      emacs-all-the-icons-fonts
      emojione
      fantasque-sans-mono
      fira-code
      font-awesome-ttf
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
