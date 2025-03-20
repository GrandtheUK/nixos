{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.follows = "chaotic/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    refind = {
      url = "github:GrandtheUK/refind-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # envision = {
    #   url = "gitlab:Scrumplex/envision/nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # jovian = {
    #   url = "github:Jovian-Experiments/Jovian-NixOS";
    #   follows = "chaotic/jovian";
    # };d 

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = [ ];
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        nix-usb = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            # chaotic.nixosModules.default
            ./nixUSB/hardware.nix
            ./common/common.nix
            ./nixUSB/core.nix
            inputs.home-manager.nixosModules.default
            # inputs.jovian.nixosModules.default
            inputs.nix-flatpak.nixosModules.nix-flatpak
            # inputs.nixpkgs.flake.overlays
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            # chaotic.nixosModules.default
            ./desktop/hardware.nix
            ./common/common.nix
            ./desktop/core.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        nix-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            inputs.refind.nixosModules.refind
            ./laptop/hardware.nix
            ./common/common.nix
            ./laptop/core.nix
          ];
        };
      };
    };
}
