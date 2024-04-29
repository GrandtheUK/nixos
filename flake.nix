{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    envision = {
      url = "gitlab:Scrumplex/rex2/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    custom-fonts = {
      url = "git+ssh://git@github.com/GrandtheUK/impact-font-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, custom-fonts, jovian, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = [ jovian.overlay ];
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        nixUSB = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./nixUSB/hardware.nix
            ./common/common.nix
            ./nixUSB/core.nix
            inputs.home-manager.nixosModules.default
            # inputs.nixpkgs.flake.overlays
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./desktop.hardware.nix
            ./common.nix
            ./desktop/core.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
