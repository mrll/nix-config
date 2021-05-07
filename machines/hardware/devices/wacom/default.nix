{ config, lib, pkgs, ... }:
let
  wacom-setup = pkgs.writeShellScriptBin "wacom-setup" ''
    #!/usr/bin/env bash

    for i in $(seq 10); do
        if xsetwacom list devices | grep -q Wacom; then
            break
        fi
        sleep 1
    done

    list=$(xsetwacom list devices)
    pad=$(echo "''${list}" | awk '/pad/{print $7}')
    stylus=$(echo "''${list}" | xsetwacom list devices | awk '/stylus/{print $7}')

    if [ -z "''${pad}" ]; then
        exit 0
    fi

    monitor=$(xrandr | grep primary | awk '{print $4}')

    xsetwacom set "''${stylus}" Rotate "half"
    xsetwacom set "''${stylus}" MapToOutput "''${monitor}"
  '';
in
lib.mkIf config.services.xserver.enable {
  # --------------------------------------------------------------------------
  # driver and script
  # --------------------------------------------------------------------------

  services.xserver.wacom.enable = true;
  environment.systemPackages = [ wacom-setup ];
}
