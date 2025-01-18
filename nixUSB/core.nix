{ config, pkgs, inputs, jovian, nixpkgs-android, ...}: {
  imports = [
    ../common/flatpak.nix
  ];
  # Temporary while using usb
  boot.loader.grub.efiInstallAsRemovable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # laptop specific packages
  users.users.ben.packages = with pkgs; [
    gimp
    obs-studio
  ];

  environment.systemPackages = with pkgs; [
    libreoffice-qt
  ];

  specialisation = {
    nvidia.configuration = {
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;

        open = false;

        nvidiaSettings = true;
      };
    };
    mixed.configuration = {
      services.xserver.videoDrivers = [ "amdgpu" "nvidia"];

      hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;

        open = false;

        nvidiaSettings = true;

        prime = {
          amdgpuBusId = "PCI:3:0:0";
          nvidiaBusId = "PCI:8:0:0";
        };
      };
    };
    jovian.configuration = {
      jovian = {
        steam = {
          enable = true;
          autoStart = true;
        };
        devices.steamdeck.enable = true;
      };
    };
  };

  # nixUSB state version. change if reinstall not from this config
  system.stateVersion = "23.11";
}
