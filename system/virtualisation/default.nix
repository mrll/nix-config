{ config, lib, pkgs, ... }:

{
  # --------------------------------------------------------------------------
  # libvirtd
  # --------------------------------------------------------------------------

  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "virbr0" ];

    onBoot = "start";
    onShutdown = "suspend";

    qemuOvmf = true;
    qemuPackage = pkgs.qemu_kvm;
    qemuRunAsRoot = false;
  };

  # --------------------------------------------------------------------------
  # packages
  # --------------------------------------------------------------------------

  environment.systemPackages = with pkgs; lib.mkIf config.services.xserver.enable [
    virt-manager
  ];
}
