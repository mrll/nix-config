{ lib, ... }:

{
  # --------------------------------------------------------------------------
  # mobile profile (using only intel graphics)
  # --------------------------------------------------------------------------

  specialisation.mobile = {
    configuration = {
      hardware.nvidia.prime = {
        sync.enable = lib.mkForce false;
        offload.enable = lib.mkForce false;
      };

      services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];
      services.hardware.bolt.enable = lib.mkForce false;

      services.logind = {
        lidSwitch = lib.mkForce "suspend";
        lidSwitchDocked = lib.mkForce "ignore";
        lidSwitchExternalPower = lib.mkForce "suspend";
      };
    };
    inheritParentConfig = true;
  };
}
