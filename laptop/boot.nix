{ config, pkgs, inputs, ...}: {
    boot = {
        loader = {
            efi.efiSysMountPoint = "/boot/efi";

            refind = {
                enable = true;
                themes = [
                    ./refind-theme-nord
                    ./test-dir
                ];
                extraConfig = ''
                include ../themes/refind-theme-nord/theme.conf
                '';
                maxGenerations = 10;
            };
        };
        supportedFilesystems = {
        btrfs = true;
        };
  };
}