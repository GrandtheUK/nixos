{ config, pkgs, ...}: {
  # Enable KDE Plasma 6
  services.xserver = {
    enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma6 = {
        enable = true;
      };
    };

  # Enable polkit
  security.polkit.enable = true;

  # Remove unused software
  environment.plasma6.excludePackages = [
      pkgs.kdePackages.elisa
      pkgs.kdePackages.kwrite
  ];

  # Add additional kde software
  environment = {
    systemPackages = with pkgs; [
      libsForQt5.polkit-kde-agent
    ];
  };
}