{ config, pkgs, inputs, ...}: {
    boot = {
        loader = {
            grub.enable = false;
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