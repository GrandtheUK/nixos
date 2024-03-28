{ config, pkgs, ...}: {
  # Envison stuff to go here
  environment.systemPackages = with pkgs; [
    opencomposite
  ];
  services.monado = {
    enable = true;
    highPriority = true;
  };
  # SteamVR stuff to go here
}