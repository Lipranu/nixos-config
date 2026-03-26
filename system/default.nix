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
    #    kernelParams = [ "intel_pstate=active" "amdgpu.modeset=0" ];
    #    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  console.useXkbConfig = true;

  nixpkgs.config = {
    allowUnfree = true;
    #permittedInsecurePackages = [
    #  "electron-25.9.0"
    #];
  };

  #virtualisation.virtualbox.host = {
  #  enable = true;
  #  enableExtensionPack = true;
  #};

  #virtualisation.virtualbox.guest.enable = true;
  virtualisation.docker.enable = true;

  hardware = {
    sane.enable = true;
    graphics.enable = true;
    openrazer.enable = true;
  };

  services = {
    pulseaudio.enable = false;
    dbus.implementation = "broker";
    power-profiles-daemon.enable = false;
    tlp.enable = true;
    thermald.enable = true;
    printing.enable = true;
    #    envfs.enable = true;

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

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };

  };

  programs.nix-ld.enable = true;
  programs.steam.enable = true;
  programs.amnezia-vpn.enable = true;
  programs.nekoray.enable = true;
  #programs.trcc-linux.enable = true;

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d --keep 5";
    };
  };

  environment.systemPackages = with pkgs; [
#    virtualboxWithExtpack
    bash
    docker-compose
    openrazer-daemon
    polychromatic
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ru ]))
  ];

  system.activationScripts.binbash = {
    # Ensure this script runs after /bin/sh is available
    deps = [ "binsh" ];
    text = ''
      mkdir -p /bin
      # Create a symlink to the default system shell (which is Bash in NixOS)
      ln -sfn ${pkgs.bash}/bin/bash /bin/bash
    '';
  };

  users.users.lipranu = {
    isNormalUser = true;
    home = "/home/lipranu";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKR3E+G7BHhwyy2/UTAgLC5NwqEculwDRDC8Lm88cpoV lipranu@inspiron" ];
    extraGroups = [
      "docker"
      "lp"
      "scanner"
      "user-with-access-to-virtualbox"
      "vboxusers"
      "wheel"
      "networkmanager"
    ];
  };

}

