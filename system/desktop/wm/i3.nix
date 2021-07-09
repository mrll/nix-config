{ config, pkgs, ... }:

{
  services = {
    xserver = {
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          arandr
          autorandr
          alacritty
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

    dbus = {
      enable = true;
      packages = [ pkgs.gnome.dconf pkgs.gcr ];
    };

    gnome.gnome-keyring.enable = true;
  };

  programs.dconf.enable = true;
}
