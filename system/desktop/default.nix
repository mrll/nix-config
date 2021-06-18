{ pkgs, ... }:

{
  imports = [
    # Window Manager
    ./wm/i3.nix
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
      autoLogin = {
        enable = true;
        user = "mrll";
      };
      lightdm = {
        enable = true;
        background = ./wallpaper/wallpaper.png;
      };
    };
  };
}
