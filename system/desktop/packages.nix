{ pkgs, ... }:

with pkgs;

let
  devPkgs = [
    vscode
    mongodb-compass
  ];
  mediaPkgs = [
    pavucontrol
    spotify
  ];
  toolsPkgs = [
    arc-theme
    arc-icon-theme
    scrcpy
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
