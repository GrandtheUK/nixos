{ config, pkgs, custom-fonts, inputs, ...}: {
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

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8*1024;
    }
  ];

  programs = {
    # enable generic linux binaries
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # missing libraries
    ];    
  };

  #enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # common boot loader/efi details
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.efiSysMountPoint = "/boot/efi";
      grub = {
        enable = true;
        efiSupport = true;
        fsIdentifier = "label";
        devices = [ "nodev" ];
        efiInstallAsRemovable = true;
      };
      # refind = {
      #   enable = true;
      # };
    };
  };

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