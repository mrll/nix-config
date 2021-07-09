{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  imports = [
    ../hardware/cpu/intel
    ../hardware/devices/all
    ../hardware/laptop
    ../hardware/ssd
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

    initrd.luks.devices = {
      root = {
        device = "/dev/nvme0n1p2";
        allowDiscards = true;
      };
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

  fileSystems."/var/lib/libvirt" = {
    device = "/dev/disk/by-uuid/c8a74d9c-fa4d-4583-a9fc-229ed119b58e";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" ];
    encrypted = {
      enable = true;
      blkDev = "/dev/sda1";
      keyFile = "/mnt-root/root/kvm-keyfile";
      label = "libvirt";
    };
  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
  };

  swapDevices = [ ];

  # --------------------------------------------------------------------------
  # nvidia egpu
  # --------------------------------------------------------------------------

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.nvidia = {
    prime = {
      offload.enable = true;
      nvidiaBusId = "PCI:6:0:0";
      intelBusId = "PCI:0:2:0";
    };
    modesetting.enable = true;
  };

  environment.systemPackages = [ nvidia-offload ];

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

  # --------------------------------------------------------------------------
  # network interfaces
  # --------------------------------------------------------------------------

  systemd.network = {
    links."10-wifi0" = {
      matchConfig.MACAddress = "dc:71:96:69:96:cd";
      linkConfig.Name = "wifi0";
    };
    links."10-ether0" = {
      matchConfig.MACAddress = "80:fa:5b:7a:ad:a5";
      linkConfig.Name = "ether0";
    };
    links."10-ether1egpu" = {
      matchConfig.MACAddress = "98:bb:1e:1c:be:06";
      linkConfig.Name = "ether1egpu";
    };
  };

  networking.wireless.interfaces = [ "wifi0" ];
}
