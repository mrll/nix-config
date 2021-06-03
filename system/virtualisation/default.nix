{ config, lib, pkgs, ... }:

{
  virtualisation = {
    # ------------------------------------------------------------------------
    # docker
    # ------------------------------------------------------------------------

    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [ "--all" ];
      };
    };

    # ------------------------------------------------------------------------
    # libvirtd
    # ------------------------------------------------------------------------

    libvirtd = {
      enable = true;
      allowedBridges = [ "virbr0" ];

      onBoot = "start";
      onShutdown = "suspend";

      qemuOvmf = true;
      qemuPackage = pkgs.qemu_kvm;
      qemuRunAsRoot = false;
    };
  };

  # --------------------------------------------------------------------------
  # packages
  # --------------------------------------------------------------------------

  environment.systemPackages = with pkgs; [
    docker-compose
    (lib.mkIf config.services.xserver.enable virt-manager)
  ];
}
