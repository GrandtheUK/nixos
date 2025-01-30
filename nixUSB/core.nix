{ config, pkgs, inputs, jovian, nixpkgs-android, ...}: {
  imports = [
    ../common/flatpak.nix
  ];
  # Temporary while using usb
  boot.loader.grub.efiInstallAsRemovable = true;

  # Corectrl
  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };

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
    # deck = {
    #   inherit (jovian);
    #   configuration = {
    #     jovian = {
    #       steam.enable = true;
    #       devices.steamdeck.enable = true;
    #     };
    #   };
    # };
  };

  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.efiSysMountPoint = "/boot/efi";
      grub = {
        enable = true;
        efiSupport = true;
        fsIdentifier = "label";
        devices = [ "nodev" ];
        efiInstallAsRemovable = true;
      };
      # refind = {
      #   enable = true;
      # };
    };
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8*1024;
    }
  ];

  # nixUSB state version. change if reinstall not from this config
  system.stateVersion = "23.11";
}
