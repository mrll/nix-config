{ pkgs, ... }:

{
  imports = [
    # Desktop Environment
    #./wm/i3.nix
    ./wm/gnome.nix
    # Configuration
    ./fonts.nix
    ./opengl.nix
    ./packages.nix
  ];

  services.xserver = {
    enable = true;
    layout = "de";
    xkbOptions = "caps:ctrl_modifier";

    desktopManager.xterm.enable = false;
    displayManager = {
      gdm = {
        enable = true;
        nvidiaWayland = true;
      };
    };

  };

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
