{ pkgs, ... }:

{
  # --------------------------------------------------------------------------
  # xserver
  # --------------------------------------------------------------------------

  services.xserver = {
    enable = true;
    useGlamor = true;
    layout = "de";
    xkbOptions = "caps:ctrl_modifier";

    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
    displayManager.lightdm = {
      enable = true;
      background = ./wallpaper/wallpaper.png;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dunst
        i3lock-fancy
        libnotify
        polybarFull
        rofi
        rofi-pass
      ];
    };
  };

  # --------------------------------------------------------------------------
  # dbus
  # --------------------------------------------------------------------------

  services.dbus = {
    enable = true;
    packages = [ pkgs.gnome3.dconf pkgs.gcr ];
  };
  programs.dconf.enable = true;

  # --------------------------------------------------------------------------
  # fonts
  # --------------------------------------------------------------------------

  fonts = {
    fonts = with pkgs; [
      fira
      fira-code
      merriweather
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      powerline-fonts
    ];
    fontconfig.defaultFonts = {
      monospace = [ "FiraCode Nerd Font" ];
      serif = [ "Merriweather" ];
      sansSerif = [ "Fira Sans Pro" ];
    };
  };

  # --------------------------------------------------------------------------
  # opengl
  # --------------------------------------------------------------------------

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  # --------------------------------------------------------------------------
  # programs
  # --------------------------------------------------------------------------

  programs = {
    browserpass.enable = true;
    vim.defaultEditor = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock-fancy}/bin/i3lock-fancy -p";
    };
  };

  # --------------------------------------------------------------------------
  # services
  # --------------------------------------------------------------------------

  services = {
    gnome3.gnome-keyring.enable = true;
  };

  # --------------------------------------------------------------------------
  # packages
  # --------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    # xserver
    arandr
    autorandr
    # terminal
    alacritty
    # browser
    tor-browser-bundle-bin
    vivaldi
    vivaldi-ffmpeg-codecs
    vivaldi-widevine
    # media
    pavucontrol
    # opengl / vulkan
    vulkan-loader
    vulkan-tools
    glxinfo
    # develop
    vscode
    # web
    thunderbird
    tdesktop
    remmina
    # gtk theme
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
  ];
}
