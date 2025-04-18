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
    overrideFolders = false;
    settings = {
      devices = {
        "Desktop" = { id = "HKEKVOA-AZF7UMF-QNZPY3I-ZUT6XZU-GEYBUMM-HJCUT7L-6IBCGAF-JDLV4AJ"; };
        "ZFold3" = { id = "2QH4QSF-SDJMZEO-RL5WNXD-NYU6TDN-AVCV3IV-FK7GHLW-6SD3D6J-7VHA5QN"; };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";

  # virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  
  system.stateVersion = "25.05";
}