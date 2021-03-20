# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:
let
  pkgs = (import (
    builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "nixos-unstable-2020-03-15";
      url = "https://github.com/nixos/nixpkgs/";
      # Commit hash for nixos-unstable as of 2018-09-12
      # `git ls-remote https://github.com/nixos/nixpkgs nixos-unstable`
      ref = "refs/heads/nixos-unstable";
      rev = "9816b99e71c3504b0b4c1f8b2e004148460029d4";
    })) {config=config;};
  home-manager = 
    builtins.fetchGit {
      name = "home-manager-unstable-2021-03-15";
      url = "https://github.com/nix-community/home-manager";
      ref = "refs/heads/master";
      rev = "07f6c6481e0cbbcaf3447f43e964baf99465c8e1";
    };
  v4l2loopback-dc = config.boot.kernelPackages.callPackage ./v4l2loopback-dc.nix { };
  passwords = 
    builtins.fetchGit {
      url = "git@github.com:Hazelfire/passwords.git";
      ref = "master";
      rev = "6e18dd56cda4f8a411198086187be3faa92a6be9";
    };
in {


  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  nixpkgs.config = import ./config.nix;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.extraOptions = ''
    plugin-files = ${pkgs.nix-plugins.override { nix = config.nix.package; }}/lib/nix/plugins/libnix-extra-builtins.so
  '';

  boot.extraModulePackages = [v4l2loopback-dc];

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.wireless.networks = {
    "Kartelei" = {
      pskRaw = builtins.extraBuiltins.pass "Wifi Kartelei Raw";
    };

    "DODO_5A95A8" = {
      pskRaw= builtins.extraBuiltins.pass "Wifi Dad's Raw";
    };

    
    "OMSFP18B" = {
      pskRaw= builtins.extraBuiltins.pass "Flip phone wifi";
    };

    #"RMIT-University" = {
      #auth=''
        #key_mgmt=WPA-EAP
        #eap=PEAP
        #identity="s3723315"
        #password="${builtins.extraBuiltins.pass "RMIT"}"
        #phase2="auth=MSCHAPV2"
        #phase1="peaplabel=0"
      #'';
    #};
  };
  swapDevices = [ { device = "/swapfile"; size = 8192; } ];
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_AU.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "dvorak-programmer";
  };

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [


    wget 
    pass

    acpi
    light
    xorg.xinit
    xorg.xauth
    (gnupg.override {guiSupport = true; pinentry=pinentry;})
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent.enable = true;
  hardware.bluetooth.enable = true;
  

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.getty = {
    autologinUser="sam";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "dvp";

    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      startx.enable = true;
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [ i3status dmenu ];
    };
    libinput.enable = true;
  };
  

  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.sam = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    };
    extraUsers.sam = {
      shell = pkgs.fish;
    };
  };
  home-manager.users.sam = import ./local/home.nix {pkgs=pkgs;config=config;};


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "unstable"; # Did you read the comment?

}

