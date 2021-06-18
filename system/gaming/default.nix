{ config, lib, pkgs, ... }:

lib.mkIf config.services.xserver.enable {
  environment.systemPackages = with pkgs; [
    ckan
    discord
    lutris
    mono
    steam-run-native
  ];
}
