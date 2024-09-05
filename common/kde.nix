{ config, pkgs, ...}: {
  # Enable KDE Plasma 6
  services = {
    xserver.enable = true;
    displayManager = {
      sddm.enable = true;
    };
    desktopManager = {
      plasma6.enable = true;
    };

  # Enable polkit
  security.polkit.enable = true;

  # Remove unused software
  environment.plasma6.excludePackages = [
      pkgs.kdePackages.elisa
      pkgs.kdePackages.kwrited
  ];

  # Add additional kde software
  environment.systemPackages = with pkgs; [
      libsForQt5.polkit-kde-agent
      konsole
      libsForQt5.kate
      libsForQt5.xdg-desktop-portal-kde
      xdg-desktop-portal
    ];


  # kde connect
  programs.kdeconnect.enable = true;
}
