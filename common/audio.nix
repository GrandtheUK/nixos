{ config, pkgs, inputs, ...}: {
  # enable audio
  # sound.enable = true;

  # enable pipewire audio server
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    helvum
  ];
}
