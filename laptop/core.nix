{ config, pkgs, inputs, jovian, nixpkgs-android, ...}: {
  imports = [
  ];
  # Temporary while using usb
  boot.loader.grub.efiInstallAsRemovable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # laptop specific packages
  users.users.ben.packages = with pkgs; [
    gimp
    obs-studio
  ];

  environment.systemPackages = with pkgs; [
    libreoffice-qt
    nixpkgs-android.android-studio
  ];

  specialisation = {
    nvidia.configuration = {
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;

        open = false;

        nvidiaSettings = true;
      };
    };
    deck.configuration = {
      imports = [
        inputs.jovian.nixosModules.default
      ];

      jovian.devices.steamdeck.enable = true;

      environment.systemPackages = with pkgs; [
        libsForQt5.qt5.qtvirtualkeyboard
        maliit-keyboard
        maliit-framework 
      ];
    };
    
  };

  # copied from configuration.nix don't remove it or nix will complain
  system.stateVersion = "23.11";
}
