{
  description = "My nixos configuration";

  inputs = {

    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs: {
    nixosConfigurations = {

      inspiron = inputs.nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
	        (import ./home)
          (import ./hardware/inspiron.nix)
          (import ./system)
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-gpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
          inputs.nixos-hardware.nixosModules.common-pc-laptop
	        inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
