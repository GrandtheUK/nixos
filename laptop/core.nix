{ config, pkgs, ...}: {
  imports = [];
  networking.hostName = "nix-laptop";
  boot.loader = {
    refind = {
      enable = true;
    };
  };
}