{ pkgs, ... }:

{
  services.xserver = {
    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        arandr
        autorandr
        dunst
        feh
        i3lock-fancy
        libnotify
        polybarFull
        rofi
        rofi-pass
      ];
    };
  };

  programs = {
    dconf.enable = true;
    xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock-fancy}/bin/i3lock-fancy -p";
    };
  };

  services = {
    dbus = {
      enable = true;
      packages = [ pkgs.gnome.dconf pkgs.gcr ];
    };
    gnome.gnome-keyring.enable = true;
  };
}
