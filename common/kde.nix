{ config, pkgs, lib, ...}: {
  # Enable KDE Plasma 6
  services = {
    xserver.enable = true;
    displayManager = {
      sddm = lib.mkDefault {
        enable = true;
        extraPackages = with pkgs; [ kdePackages.qtvirtualkeyboard ];
      };
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
      xdg-desktop-portal
      maliit-keyboard
      maliit-framework
    ]) ++ (with pkgs.kdePackages; [
      konsole
      plasma-workspace
      kate
      xdg-desktop-portal-kde
      polkit-kde-agent-1
      kcalc
      partitionmanager
      qtvirtualkeyboard
    ]);


  # kde connect
  programs.kdeconnect.enable = true;
}
