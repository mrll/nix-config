{ config, lib, pkgs, ... }:

lib.mkIf config.services.xserver.enable {
  # --------------------------------------------------------------------------
  # gaming packages
  # --------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    discord
    lutris
    steam-run-native
  ];
}
