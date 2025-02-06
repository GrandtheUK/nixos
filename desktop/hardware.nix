{ config, lib, pkgs, ... }:

{
    boot = {
        initrd = {
            availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
            kernelModules = [];
        };
        kernelModules = [ "kvm_amd" ];
        extraModulePackages = [];
    };

    fileSystems = {
        "/" = {
            device = "/dev/disk/by-label/ROOT";
            fsType = "ext4";
        };
        "/boot/efi" = {
            device = "/dev/disk/by-label/BOOT";
            fsType = "vfat";
        };
    };
    swapDevices = [];

    networking.useDHCP = lib.mkDefault true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}