{ config, pkgs, ... }:

{
  imports = [ ./secrets/wifi_networks.nix ];

  # --------------------------------------------------------------------------
  # network
  # --------------------------------------------------------------------------

  networking = {
    networkmanager.enable = false;

    wireless = {
      enable = true;
      userControlled.enable = true;
    };

    firewall = {
      enable = true;
      allowPing = false;
    };
  };

  # --------------------------------------------------------------------------
  # sound
  # --------------------------------------------------------------------------

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    support32Bit = true;
  };

  # --------------------------------------------------------------------------
  # bluetooth
  # --------------------------------------------------------------------------

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
  };
  services.blueman.enable = config.services.xserver.enable;

  # --------------------------------------------------------------------------
  # locale, region & console
  # --------------------------------------------------------------------------

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  time.timeZone = "Europe/Berlin";

  console.keyMap = "de";
  console.font = "Lat2-Terminus16";

  # --------------------------------------------------------------------------
  # upower
  # --------------------------------------------------------------------------

  services.upower.enable = true;
  systemd.services.upower.enable = true;

  # --------------------------------------------------------------------------
  # nix & system
  # --------------------------------------------------------------------------

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    allowedUsers = [ "@users" ];
    trustedUsers = [ "root" "@wheel" ];
  };
  nixpkgs.config.allowUnfree = true;

  boot.cleanTmpDir = true;
  system.stateVersion = "20.09";

  # --------------------------------------------------------------------------
  # programs
  # --------------------------------------------------------------------------

  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = true;
      enableCompletion = true;

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [
          "direnv"
          "git"
          "gitignore"
          "man"
          "pass"
          "sudo"
          "zsh-interactive-cd"
        ];
      };

      shellAliases = {
        cat = "bat";
        ps = "procs";
      };
    };
  };

  # --------------------------------------------------------------------------
  # packages
  # --------------------------------------------------------------------------

  environment.systemPackages = with pkgs;[
    # tools
    bat
    bottom
    direnv
    fzf
    neofetch
    nixpkgs-fmt
    procs
    starship
    tree
    # files
    ranger
    # archives
    gnutar
    unrar
    unzip
    xz
    zip
    # web
    curl
    gitAndTools.gitFull
    git-crypt
    gnupg
    rsync
    w3m
    wget
    # media
    playerctl
    # security
    gopass
    pass
  ];
}
