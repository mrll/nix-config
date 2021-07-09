{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      desktopManager.gnome.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.arcmenu
    gnomeExtensions.appindicator
    gnomeExtensions.espresso
    gnomeExtensions.net-speed-simplified
    gnomeExtensions.screenshot-tool
    gnome.gnome-tweaks
    libappindicator
    wl-clipboard
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome.geary
    gnome.epiphany
    gnome-connections
    gnome-tour
  ];

  services.tlp.enable = lib.mkForce false;
}
