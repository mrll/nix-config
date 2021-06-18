{ pkgs, ... }:

with pkgs;

let
  devPkgs = [
    vscode
    mongodb-compass
  ];
  mediaPkgs = [
    celluloid
    darktable
    gnome.cheese
    gthumb
    lightworks
    pavucontrol
    pinta
    spotify
    xournalpp
  ];
  toolsPkgs = [
    arc-theme
    arc-icon-theme
    alacritty
    vulkan-loader
    vulkan-tools
    glxinfo
  ];
  webPkgs = [
    nmap-graphical
    tdesktop
    thunderbird
    tor-browser-bundle-bin
    remmina
    vivaldi
    vivaldi-ffmpeg-codecs
    vivaldi-widevine
    wireshark
  ];
in
{
  programs.browserpass.enable = true;

  environment.systemPackages = devPkgs ++ mediaPkgs ++ toolsPkgs ++ webPkgs;
}
