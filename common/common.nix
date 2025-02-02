{ config, pkgs, inputs, ...}: {
  # specialArgs = {inherit inputs;};
  imports = [
    inputs.home-manager.nixosModules.default
    ./kde.nix
    ./gaming.nix
    ./audio.nix
    ./tailscale.nix
    ./distrobox.nix
  ];
  # enable all software
  nixpkgs.config.allowUnfree = true;

  

  programs = {
    # enable generic linux binaries
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # missing libraries
    ];    
  };

  #enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Networking & timezone
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/London";

  # set up home-manager and user accounts

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "ben" = import ./home.nix;
    };
  };
  users.users.ben = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    # common user packages. temporary.
    packages = with pkgs; [
      discord
      discord-canary
      vscodium
      krita
      cargo
      rustc
      hugo
      go
      gimp
      waypipe
      fusee-nano
      fusee-interfacee-tk
    ] ++ [
      inputs.zen-browser.packages."${system}".default
    ];
  };

  # common system packages
  environment.systemPackages = with pkgs; [
    nh
    nano
    wget
    git
    btrfs-progs
    nix-output-monitor
    barrier
    usbutils
  ];

  fonts.packages = with pkgs; [
    corefonts
  ];

  services.avahi = {
    nssmdns4 = true;
    enable = true;
    ipv4 = true;
    ipv6 = false;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}