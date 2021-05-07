{ pkgs, ... }:

{
  # --------------------------------------------------------------------------
  # firmware
  # --------------------------------------------------------------------------

  hardware.cpu.intel.updateMicrocode = true;

  # --------------------------------------------------------------------------
  # opengl packages
  # --------------------------------------------------------------------------

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];
}
