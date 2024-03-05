{ config, pkgs, ...}: {
  imports = [
  ];
  boot.loader.grub.efiInstallAsRemovable = true; # Temporary while using usb

  # laptop specific packages
  users.users.ben.packages = with pkgs; [
    gimp
  ];

  # copied from configuration.nix don't remove it or nix will complain
  system.stateVersion = "23.11";
}