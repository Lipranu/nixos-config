{
  description = "My nixos configuration";

  inputs = {

    nixpkgs-unstable = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    nixpkgs-stable = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-20.09";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

  };

  outputs = inputs: {
    nixosConfigurations = {

      inspiron = inputs.nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./src/configuration.nix)
        ];
        specialArgs = { inherit inputs; };
      };

    };
  };
}
