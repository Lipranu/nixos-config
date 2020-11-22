{
  home-manager.users.lipranu.programs.firefox = {
    enable = true;
    profiles.default.settings = {
      "browser.shell.checkDefaultBrowser" = false;
    };
  };
}
