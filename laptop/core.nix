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
    dataDir = "/home/ben/Documents";
    configDir = "/home/ben/.config/syncthing";
    user = "ben";
    settings.gui = {
      user = "ben";
      password = "temporary";
    };
  };
  
  system.stateVersion = "25.05";
}