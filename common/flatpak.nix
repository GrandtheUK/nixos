{ config, pkgs, ...}: {
  services.flatpak = {
    enable = true;
    packages = [
      "dev.vencord.Vesktop"
    ];
  };
  xdg.portal.enable = true;
}