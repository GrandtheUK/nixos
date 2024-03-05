{ config, pkgs, ...}: {
  imports = [
    ./vr.nix
  ];
  # misc packages
  users.users.ben.packages = with pkgs; [
    firefox
    libsForQt5.kate
    discord
    vscodium
    gimp
  ];
}