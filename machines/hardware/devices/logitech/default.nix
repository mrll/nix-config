{ config, ... }:

{
  # --------------------------------------------------------------------------
  # logitech
  # --------------------------------------------------------------------------

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = config.services.xserver.enable;
  };

  # --------------------------------------------------------------------------
  # intird module for luks entry
  # --------------------------------------------------------------------------

  boot.initrd.availableKernelModules = [ "hid-logitech-hidpp" ];
}
