{ config, pkgs, inputs, nixpkgs, ...}: {
  # Envison stuff to go here
  nixpkgs.xr.enable = true;

  environment.systemPackages = [
    inputs.envision.packages.x86_64-linux.envision
    pkgs.wlx-overlay-s
  ];
  # services.monado = {
  #   enable = true;
  #   highPriority = true;
  # };
  # SteamVR stuff to go here
}