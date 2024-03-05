{ config, pkgs, ...}: {
  imports = [
  ];
  # Temporary while using usb
  boot.loader.grub.efiInstallAsRemovable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # laptop specific packages
  users.users.ben.packages = with pkgs; [
    gimp
  ];

  environment.systemPackages = with pkgs; [
    libreoffice-qt
  ];

  # copied from configuration.nix don't remove it or nix will complain
  system.stateVersion = "23.11";
}
