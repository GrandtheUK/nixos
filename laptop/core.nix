{ config, pkgs, inputs, ...}: {
  imports = [
    ./boot.nix
  ];
  networking.hostName = "nix-laptop";
  environment.systemPackages = with pkgs; [
    libreoffice-qt6
  ];
  
  system.stateVersion = "25.05";
}