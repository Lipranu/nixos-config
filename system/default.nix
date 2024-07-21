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

  sound.enable = true;

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
    opengl.enable = true;
    openrazer.enable = true;
  };

  services = {
    printing.enable = true;

    xserver = {
      enable = true;
      libinput.enable = true;
#      videoDrivers = [ "amdgpu" ];

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

