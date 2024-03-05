{ config, pkgs, ...}: {
  imports = [
    # ./hardware.nix
  ];

  # laptop specific packages
  users.users.ben.packages = with pkgs; [
    firefox
    libsForQt5.kate
    discord
    vscodium
    gimp
  ];
}