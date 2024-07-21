{ config, pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./network.nix
    ./nix.nix
  ];

  system.stateVersion = "20.09";
  #systemd.network.enable = true;
  time.timeZone = "Asia/Novosibirsk";

  boot = {
    kernelParams = [ "intel_pstate=active" "amdgpu.modeset=0"];
    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  console.useXkbConfig = true;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  #virtualisation.virtualbox.host = {
  #  enable = true;
  #  enableExtensionPack = true;
  #};

  #virtualisation.virtualbox.guest.enable = true;
  virtualisation.docker.enable = true;

  hardware = {
    pulseaudio.enable = true;
    sane.enable = true;
    graphics.enable = true;
    openrazer.enable = true;
  };

  services = {
    printing.enable = true;

    libinput.enable = true;

    displayManager = {
      defaultSession = "xsession";

      autoLogin = {
        enable = true;
        user = "lipranu";
      };

    };

    xserver = {
      enable = true;
      displayManager = {
	      session = [{
	        manage = "desktop";
	        name = "xsession";
	        start = "";
	      }];
      };
    };

  };

  programs.nix-ld.enable = true;
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
#    virtualboxWithExtpack
    docker-compose
    openrazer-daemon
    polychromatic
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ru ]))
  ];

  users.users.lipranu = {
    isNormalUser = true;
    home = "/home/lipranu";
    extraGroups = [
      "docker"
      "lp"
      "scanner"
      "user-with-access-to-virtualbox"
      "vboxusers"
      "wheel"
    ];
  };

}

