{ config, pkgs, inputs, ...}: {
    boot = {
        loader = {
            grub.enable = false;
            refind = {
                enable = true;
                extraPaths = [
                    ./refind-theme-nord
                ];
                extraConfig = ''
                include ../../refind/refind-theme-nord/theme.conf
                '';
            };
        };
        supportedFilesystems = {
        btrfs = true;
        };
  };
}