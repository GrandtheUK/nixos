{ config, pkgs, ...}: {
  imports = [];
  networking.hostname = "nix-laptop";
  boot.loader = {
    refind = {
      enable = true;
    }
  }
}