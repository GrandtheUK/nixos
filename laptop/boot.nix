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
                include ../../refind/themes/refind-theme-nord/theme.conf
                '';
            };
        };
        supportedFilesystems = {
        btrfs = true;
        };
  };
}