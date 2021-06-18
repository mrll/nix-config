{ pkgs, ... }:

with pkgs;

let
  devPkgs = [
    vscode
    mongodb-compass
  ];
  mediaPkgs = [
    darktable
    gthumb
    pavucontrol
    spotify
    celluloid
    gnome.cheese
    lightworks
  ];
  toolsPkgs = [
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
