{ config, pkgs, inputs, ...}: {
  imports = [];
  networking.hostName = "nix-laptop";
  boot.loader = {
    grub.enable = false;
    refind.enable = true;
  };
}