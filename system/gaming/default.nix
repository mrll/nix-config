{ config, lib, pkgs, ... }:

lib.mkIf config.services.xserver.enable {
  environment.systemPackages = with pkgs; [
    discord
    lutris
    steam-run-native
  ];
}
