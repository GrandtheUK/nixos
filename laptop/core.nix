{ config, pkgs, inputs, ...}: {
  imports = [
    ./boot.nix
  ];
  networking.hostName = "nix-laptop";
  environment.systemPackages = with pkgs; [
    libreoffice-qt6
  ];
  hardware.bluetooth.enable = true;
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };
  
  system.stateVersion = "25.05";
}