{ pkgs, ... }:

{
  # --------------------------------------------------------------------------
  # utility packages
  # --------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    lm_sensors
    wirelesstools
    pciutils
    usbutils
  ];

  # --------------------------------------------------------------------------
  # power management
  # --------------------------------------------------------------------------

  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_HWP_ON_AC = "performance";
    USB_BLACKLIST_PHONE = 1;
    PCIE_ASPM_ON_AC = "performance";
    PCIE_ASPM_ON_BAT = "default";
  };

  # --------------------------------------------------------------------------
  # libinput (touchpad)
  # --------------------------------------------------------------------------

  services.xserver.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
}
