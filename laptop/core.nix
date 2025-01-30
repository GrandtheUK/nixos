{ config, pkgs, inputs, ...}: {
  imports = [];
  networking.hostName = "nix-laptop";
  boot = {
    loader = {
      grub.enable = false;
      refind.enable = true;
    };
    supportedFilesystems = {
      btrfs = true;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_5_10;
  };
  system.stateVersion = "25.05";
}