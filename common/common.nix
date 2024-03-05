{ config, pkgs, custom-fonts, ...}: {
  specialArgs = {inherit inputs;};
  imports = [
    inputs.home-manager.nixosModules.default
    ./kde.nix
    ./gaming.nix
  ];
  # enable all software
  nixpkgs.config.allowUnfree = true;

  #enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # common boot loader/efi details
  boot.loader = {
    systemd-boot.enable = false;
    efi.efiSysMountPoint = "/boot/efi";
    grub = {
      enable = true;
      efiSupport = true;
      fsIdentifier = "label";
      devices = [ "nodev" ];
    }
  }

  # Networking & timezone
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/London";

  # set up home-manager and user accounts

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ben" = import ./home.nix
    }
  }
  users.users.ben = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  }
}