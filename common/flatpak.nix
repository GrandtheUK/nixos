{ config, pkgs, ...}: {
  programs.flatpak.enable = true;
  xdg.portal.enable = true;
}