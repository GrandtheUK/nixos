{ config, pkgs, ...}: {
  imports = [

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