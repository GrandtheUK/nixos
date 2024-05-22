{ config, pkgs, inputs, ...}: {
  # Envison stuff to go here
  environment.systemPackages = [
    inputs.envision.packages.envision
  ];
  # services.monado = {
  #   enable = true;
  #   highPriority = true;
  # };
  # SteamVR stuff to go here
}