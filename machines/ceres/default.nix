{ pkgs, ... }:

{
  imports = [
    ../hardware/cpu/intel
    ../hardware/devices/all
    ../hardware/laptop
    ../hardware/ssd
  ] ++ [
    ./mobile.nix
  ];

  networking.hostName = "ceres";

  # --------------------------------------------------------------------------
  # bootloader
  # --------------------------------------------------------------------------

  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
        copyKernels = true;
      };
      efi.canTouchEfiVariables = true;
    };

    # ------------------------------------------------------------------------
    # luks partition
    # ------------------------------------------------------------------------

    initrd.luks.devices.root = {
      device = "/dev/nvme0n1p2";
      allowDiscards = true;
    };

    # ------------------------------------------------------------------------
    # kernel & modules
    # ------------------------------------------------------------------------

    kernelPackages = pkgs.linuxPackages_latest;

    initrd.availableKernelModules = [
      "aesni_intel"
      "ahci"
      "alx"
      "cryptd"
      "nvme"
      "nls_cp437"
      "nls_iso8859-1"
      "rtsx_pci_sdmmc"
      "sd_mod"
      "usbhid"
      "usb_storage"
      "vfat"
      "xhci_pci"
    ];
    initrd.kernelModules = [ "dm-snapshot" ];
    kernelModules = [ "kvm-intel" ];
  };

  # --------------------------------------------------------------------------
  # partitions
  # --------------------------------------------------------------------------

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6b4ba9a8-10a1-4b8e-892a-be89739a42d4";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
  };

  swapDevices = [ ];

  # --------------------------------------------------------------------------
  # nvidia egpu
  # --------------------------------------------------------------------------

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    prime = {
      sync.enable = true;
      sync.allowExternalGpu = true;
      nvidiaBusId = "PCI:6:0:0";
      intelBusId = "PCI:0:2:0";
    };
    modesetting.enable = true;
  };

  # --------------------------------------------------------------------------
  # thunderbolt for egpu
  # --------------------------------------------------------------------------

  services.hardware.bolt.enable = true;
  systemd.services.display-manager.after = [ "bolt.service" ];

  # --------------------------------------------------------------------------
  # logind
  # --------------------------------------------------------------------------

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # --------------------------------------------------------------------------
  # kvmgt
  # --------------------------------------------------------------------------

  virtualisation.kvmgt = {
    enable = true;
    device = "0000:00:02.0";
    vgpus = {
      i915-GVTg_V5_4 = { uuid = [ "712046d2-c8e8-4daa-9757-43645d6ad6af" ]; };
    };
  };
}
