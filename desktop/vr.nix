{ config, pkgs, inputs, ...}: {
  # Envison stuff to go here
  environment.systemPackages = [
#    inputs.envision.packages.x86_64-linux.envision
    inputs.nixpkgs-xr.packages.x86_64-linux.wlx-overlay-s
  ];
  # programs.envision = {
  #   enable = true;
  # };
  services.monado = {
    enable = true;
    highPriority = true;
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
  # SteamVR stuff to go here
}
