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
    settings = {
      devices = {
        "Desktop" = { id = "HKEKVOA-AZF7UMF-QNZPY3I-ZUT6XZU-GEYBUMM-HJCUT7L-6IBCGAF-JDLV4AJ"; };
        "ZFold3" = { id = "2QH4QSF-SDJMZEO-RL5WNXD-NYU6TDN-AVCV3IV-FK7GHLW-6SD3D6J-7VHA5QN"; };
      };
      folders = {
        "9ax4a-smam2" = {
          path = "/home/ben/Documents/TTRPG";
          devices = [ "Desktop" "ZFold3" ];
          ignorePerms = true;
        };
      };
    };
  };
  
  system.stateVersion = "25.05";
}