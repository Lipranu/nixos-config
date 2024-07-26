{ config, pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./network.nix
    ./nix.nix
  ];

  zramSwap.enable = true;

  system.stateVersion = "20.09";
  #systemd.network.enable = true;
  time.timeZone = "Asia/Novosibirsk";

  boot = {
    kernelParams = [ "intel_pstate=active" "amdgpu.modeset=0" ];
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
    pulseaudio.enable = false;
    sane.enable = true;
    graphics.enable = true;
    openrazer.enable = true;
  };

  services = {
    dbus.implementation = "broker";
    power-profiles-daemon.enable = false;
    tlp.enable = true;
    thermald.enable = true;
    printing.enable = true;

    libinput.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

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

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d --keep 5";
    };
  };

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

