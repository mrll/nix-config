{ config, pkgs, ... }:

{
  services = {
    xserver = {
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

      xautolock = {
        enable = true;
        enableNotifier = true;
        extraOptions = [ "-detectsleep" "-corners" "00-0" ];
        killer = "/run/current-system/systemd/bin/systemctl suspend";
        killtime = 20;
        locker = "/run/current-system/sw/bin/i3lock-fancy -p";
        notifier = ''/run/current-system/sw/bin/notify-send "Locking in 20 seconds"'';
        notify = 20;
        nowlocker = config.services.xserver.xautolock.locker;
        time = 10;
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
