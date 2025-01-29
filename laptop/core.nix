{ config, pkgs, ...}: {
  imports = [];
  boot.loader = {
    refind = {
      enable = true;
    }
  }
}