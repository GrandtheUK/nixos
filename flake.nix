{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.follows = "chaotic/nixpkgs";

    refind = {
      url = "git+https://github.com/betaboon/nixpkgs?rev=66166496b68920bea56d9be1b068bf68550531e9";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # envision = {
    #   url = "gitlab:Scrumplex/envision/nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    custom-fonts = {
      url = "git+ssh://git@github.com/GrandtheUK/impact-font-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # jovian = {
    #   url = "github:Jovian-Experiments/Jovian-NixOS";
    #   follows = "chaotic/jovian";
    # };
    nixpkgs-xr = {
      url = "github:nix-community/nixpkgs-xr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, refind, custom-fonts, nixpkgs-xr, nix-flatpak, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = [ ];
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        nixUSB = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            # chaotic.nixosModules.default
            ./nixUSB/hardware.nix
            ./common/common.nix
            ./nixUSB/core.nix
            ./desktop/vr.nix
            inputs.home-manager.nixosModules.default
            # inputs.jovian.nixosModules.default
            nixpkgs-xr.nixosModules.nixpkgs-xr
            nix-flatpak.nixosModules.nix-flatpak
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
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            "${refind}/system/boot/loader/refind/refind.nix"
            ./laptop/hardware.nix
            ./common/common.nix
            ./laptop/core.nix
          ];
        };
      };
    };
}
