{ config, pkgs, inputs, ...}: {
    boot = {
        loader = {
            efi = {
                efiSysMountPoint = "/boot/efi";
                canTouchEfiVariables = true;
            };

            refind = {
                enable = true;
                themes = [
                    ./refind-theme-nord
                    ./test-dir
                ];
                extraConfig = ''
                include themes/nord/theme.conf
                '';
                maxGenerations = 10;
            };
        };
        supportedFilesystems = {
        btrfs = true;
        };
  };
}