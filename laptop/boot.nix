{ config, pkgs, inputs, ...}: {
    boot = {
        loader = {
        grub.enable = false;
        refind.enable = true;
        };
        supportedFilesystems = {
        btrfs = true;
        };
  };
}