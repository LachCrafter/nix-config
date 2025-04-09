# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
 
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.xserver = {
   enable = true;
   xkb.layout = "de";
   desktopManager.gnome.enable = true;
   displayManager.gdm.enable = true;
  };

  hardware.graphics = {
   enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
   modesetting.enable = true;
   powerManagement.enable = true;
   open = true;
   nvidiaSettings = true;
   package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "570.133.07";
    sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
    sha256_aarch64 = "sha256-yTovUno/1TkakemRlNpNB91U+V04ACTMwPEhDok7jI0=";
    openSha256 = "sha256-9l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
    settingsSha256 = "sha256-XMk+FvTlGpMquM8aE8kgYK2PIEszUZD2+Zmj2OpYrzU=";
    persistencedSha256 = "sha256-G1V7JtHQbfnSRfVjz/LE2fYTlh9okpCbE4dfX9oYSg8=";
   };
  };
  
  # Configure keymap in X11
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Audio
  services.pipewire = {
   enable = true;
   pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lachcrafter = {
   isNormalUser = true;
   extraGroups = [ "wheel" "vboxusers" ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
     firefox
     tree
     discord
     spotify
   ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neofetch
    tmux
    kitty
    prismlauncher
    ntfs3g
    gnome-tweaks
    bind
    gpu-screen-recorder
    gpu-screen-recorder-gtk
    python3
    gimp
    parted
    monero-gui
    kdePackages.kdenlive
    wireshark
    pavucontrol
    qbittorrent
    vlc
    unrar
    unzip
    psmisc
    filezilla
 
    # ides
    jetbrains.idea-community-bin
    vscode

    # dev-tools
    gcc13
    git
    binutils
    cmake
    gnumake
    pkg-config
    go
    nodejs_22
    linuxPackages.perf
    perf-tools
    mono
    gdb
    valgrind
    rustc
    whois
    rustup
    rust-cbindgen
    astyle
    
    # misc
    obs-studio
    neovim
    python312Packages.pip
    python312Packages.tree-sitter
    python312Packages.pynvim
    fd
    ripgrep
    gnupg
    jetbrains-mono
    corefonts
    vistafonts
    fastfetch
    nasm
    qemu
    pinentry
    libreoffice-fresh
    element-desktop
    avalonia-ilspy
    musescore
    maven
    floorp
    iotas
   ];
   
   environment.etc = with pkgs; {
    "jdk".source = jdk;
    "jdk8".source = jdk8;
    "jdk11".source = jdk11;
    "jdk17".source = jdk17;
    "jdk21".source = jdk21;
    "zulu8".source = zulu8;
    "jetbrains_jdk".source = jetbrains.jdk;
    "jetbrains_jdk17".source = jetbrains.jdk-no-jcef-17;
    "jetbrains_jdk21".source = jetbrains.jdk-no-jcef;
  };

  # setup zsh
   programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true; # Optional: Enables Oh My Zsh
      theme = "robbyrussell"; # You can choose any available theme
      plugins = [ "git" "z" "sudo" ]; # Add desired plugins
    };
    # Optionally, set Zsh as the default shell for all users
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };

  # Mullvad vpn
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn; 

  # Garbage collection
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.auto-optimise-store = true;
  };

  users.defaultUserShell = pkgs.zsh;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

