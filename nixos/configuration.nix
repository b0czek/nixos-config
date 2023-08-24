# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nfs.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nixpooter"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  

  # Enable the KDE Plasma Desktop Environment.
  services.xserver = {
    displayManager = {
      gdm = {
        enable = true;
  	    wayland = true;
      };
      defaultSession = "plasmawayland";
    };
    desktopManager = {
      plasma5.enable = true;
    };
  };

  services.vnstat.enable = true;
  
  # Configure keymap in X11
  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;


    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

nixpkgs.overlays =
  let
    # Change this to a rev sha to pin
    moz-rev = "master";
    moz-url = builtins.fetchTarball { url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";};
    nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
  in [
    nightlyOverlay
  ];
programs.firefox.package = pkgs.latest.firefox-nightly-bin;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dariusz = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Dariusz Majnert";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" "adbusers" "wireshark" "dialout"];
    packages = with pkgs; [


    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix = {
     package = pkgs.nixFlakes;
     extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
       "experimental-features = nix-command flakes";
  };


  
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.adb.enable = true;
  programs.wireshark.enable = true;
  programs.partition-manager.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde

      ];
    };

  };

  virtualisation = {
  	libvirtd.enable = true;
  	docker.enable = true;
  };

  environment.shells = with pkgs; [ fish ];
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

   # browsers
     chromium
     #firefox
     latest.firefox-nightly-bin

   # kde desktop
     kate
     kdiskmark
     gnome.adwaita-icon-theme
     libsForQt5.filelight
     libsForQt5.yakuake
     qalculate-qt


   # desktop programs
     spotify
     telegram-desktop
     discord
     obs-studio
     qbittorrent
     mpv
     wireshark	  
     libreoffice-qt
     virt-manager
     droidcam
     helvum    

   # cli utilities
     htop
     neofetch
     micro
     yt-dlp
     ffmpeg
     radeontop
     wol
     inetutils
     cabextract
     unzip
     android-tools
     wget
     ventoy-full
     yad #?
     nixos-generators
     multipath-tools

     
   # runtimes(?)
     openjdk17
     appimage-run
     nfs-utils

   # wine
     wineWowPackages.stagingFull
     winetricks
   
   # games
     prismlauncher
     lutris
     yuzu-mainline

   # fish plugins
     fishPlugins.fzf-fish
     fzf
     fd
     bat
     fishPlugins.grc
     grc

   # 3d design
     prusa-slicer
     openscad
     freecad
     blender    
     kicad
     
   # pdf manipulation
     poppler_utils	
     pdftk


   # dev
     gcc
     gnumake
     clang
     git
     jetbrains.idea-ultimate
     rustup
     insomnia

     (vscode-with-extensions.override {
       vscode = vscodium;
       vscodeExtensions = with vscode-extensions; [
         bbenoist.nix
         ms-python.python
         ms-azuretools.vscode-docker
         ms-vscode-remote.remote-ssh
         rust-lang.rust-analyzer
         bungcip.better-toml
       ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
         # {
           # name = "remote-ssh-edit";
           # publisher = "ms-vscode-remote";
           # version = "0.47.2";
           # sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
         # }
       ];
     })

     
  ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
