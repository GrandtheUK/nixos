{ config, pkgs, inputs, ...}: {
  # Envison stuff to go here
  environment.systemPackages = [
#    inputs.envision.packages.x86_64-linux.envision
    inputs.nixpkgs-xr.packages.x86_64-linux.wlx-overlay-s
  ];
  programms.envision = {
    enable = true;
  };
  # services.monado = {
  #   enable = true;
  #   highPriority = true;
  # };
  # SteamVR stuff to go here
}
