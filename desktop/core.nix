{ config, pkgs, ...}: {
  imports = [
    ./vr.nix
  ];
  # misc packages
  users.users.ben.packages = with pkgs; [
    firefox
    libsForQt5.kate
    discord
    vscodium
    gimp
  ];
  boot.loader = {
    grub.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };
}