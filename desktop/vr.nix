{ config, pkgs, inputs, ...}: {
  # Envison stuff to go here
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