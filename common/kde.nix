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
  };

  # Enable polkit
  security.polkit.enable = true;

  # Remove unused software
  environment.plasma6.excludePackages = with pkgs; [
      kdePackages.elisa
      kdePackages.kwrited
  ];

  # Add additional kde software
  environment.systemPackages = (with pkgs; [
      konsole
      xdg-desktop-portal
    ]) ++ (with pkgs.libsForQt5; [
      kate
      xdg-desktop-portal-kde
      polkit-kde-agent
      kcalc
    ]) ++ (with pkgs.kdePackages; [
      partitionmanager
    ]);


  # kde connect
  programs.kdeconnect.enable = true;
}
