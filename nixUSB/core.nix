{ config, pkgs, lib, inputs, jovian, nixpkgs-android, ...}: {
  imports = [
    ../common/flatpak.nix
  ];
  networking.hostName = "nix-usb";

  # Corectrl
  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.lightdm.enable = true;


  # security.wrappers = {
  #   "steamVR" = {
  #     capabilities = "set_cap_nice+eip";
  #     source = "/home/ben/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher";
  #     owner = "ben";
  #     group = "users";
  #   };
  # };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Envision additional packages
  programs.envision = {
    enable = true;
    # add missing deps TODO
  };

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
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "uas" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm_amd" ];
    extraModulePackages = [ ];
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8*1024;
    }
  ];

  # nixUSB state version. change if reinstall not from this config
  system.stateVersion = "25.05";
}
