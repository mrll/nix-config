{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
  };
  services.blueman.enable = config.services.xserver.enable;
}
