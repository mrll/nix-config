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

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    pulse.enable = true;
  };

  #hardware.pulseaudio = {
  #  enable = true;
  #  package = pkgs.pulseaudioFull;
  #  extraModules = [ pkgs.pulseaudio-modules-bt ];
  #  support32Bit = true;
  #};

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
  boot.plymouth.enable = true;
  system.stateVersion = "20.09";

  # --------------------------------------------------------------------------
  # programs / services
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
    };
  };
  services = {
    fwupd = {
      enable = true;
    };
  };

  # --------------------------------------------------------------------------
  # environment
  # --------------------------------------------------------------------------

  environment = {
    shells = with pkgs; [ bash nushell zsh ];
    shellAliases = {
      # bat
      cat = "bat";
      # exa
      ls = "exa --icons";
      ll = "ls -l";
      la = "ls -al";
      tree = "ls --tree";
      # procs
      ps = "procs";
      # zoxide
      zq = "zoxide query";
    };
  };

  # --------------------------------------------------------------------------
  # packages
  # --------------------------------------------------------------------------

  environment.systemPackages = with pkgs;[
    # shell / core
    bat
    bandwhich
    bottom
    du-dust
    exa
    fd
    fzf
    nushell
    procs
    ripgrep
    sd
    starship
    tealdeer
    zoxide
    # tools
    direnv
    neofetch
    nixpkgs-fmt
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
    nmap
    rsync
    w3m
    wireshark-cli
    wget
    # media
    playerctl
    imagemagick
    # security
    gopass
    pass
  ];
}
