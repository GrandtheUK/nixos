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

  i18n.defaultLocale = "en_GB.UTF-8";

  programs = {
    # enable generic linux binaries
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # missing libraries
    ];  
    extra-container.enable = true;
    nh = {
      enable = true;
      flake = "/home/ben/.nixos";
    };
  };

  #enable flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # Networking & timezone
  networking.networkmanager = {
    enable = true;
  };
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
    extraGroups = [ "wheel" "libvirtd" ];
    # common user packages. temporary.
    packages = with pkgs; [
      discord
      discord-canary
      betterdiscordctl
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          rust-lang.rust-analyzer
          jnoortheen.nix-ide
        ];
      })
      krita
      hugo
      go
      gimp
      waypipe
      fusee-nano
      fusee-interfacee-tk
      gfxtablet
    ] ++ [
      inputs.zen-browser.packages."${system}".default
    ];
  };

  networking.firewall.allowedUDPPorts = [ 40118 ];

  # common system packages
  environment.systemPackages = (with pkgs; [
    nano
    wget
    git
    btrfs-progs
    nix-output-monitor
    barrier
    usbutils
    spacetimedb
    wireguard-tools
  ]) ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
    osu-stable
  ]);

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