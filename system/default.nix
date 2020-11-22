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
  hardware.pulseaudio.enable = true;

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

  users.users.lipranu = {
    isNormalUser = true;
    home = "/home/lipranu";
    extraGroups = [ "wheel" ];
  };

}

