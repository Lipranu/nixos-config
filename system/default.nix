{ config, pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./network.nix
    ./nix.nix
  ];

  system.stateVersion = "20.09";

  time.timeZone = "Asia/Novosibirsk";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  sound.enable = true;

  nixpkgs.config = { allowUnfree = true; };

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  hardware = {
    pulseaudio.enable = true;
    sane.enable = true;
  };

  services = {
    printing.enable = true;

    xserver = {
      enable = true;
      libinput.enable = true;

      displayManager = {
        defaultSession = "xsession";

	      session = [{
	        manage = "desktop";
	        name = "xsession";
	        start = "";
	      }];

        autoLogin = {
          enable = true;
          user = "lipranu";
        };

      };

    };

  };

  environment.systemPackages = with pkgs; [
    virtualboxWithExtpack
  ];

  users.users.lipranu = {
    isNormalUser = true;
    home = "/home/lipranu";
    extraGroups = [
      "lp"
      "scanner"
      "user-with-access-to-virtualbox"
      "vboxusers"
      "wheel"
    ];
  };

}

