{
  description = "My NixOS configuration";

  inputs = {
    # NixOS / Packages
    nixos.url = "github:NixOS/nixpkgs/nixos-21.05";
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Flake Utils Plus
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = inputs@{ self, nixos, nixos-unstable, utils }:
    utils.lib.systemFlake {
      inherit self inputs;

      # Supported systems, used for packages, apps, devShell and multiple other definitions..
      supportedSystems = [ "x86_64-linux" ];

      ################
      ### channels ###
      ################

      # Configuration that is shared between all channels.
      channelsConfig = { allowUnfree = true; };

      # Specific channel configuration
      channels.nixpkgs = {
        # Nixpkgs flake reference to be used in the configuration.
        input = nixos;

        # Overlays to apply on a selected channel.
        overlaysBuilder = channels: [
          # Overwrites specified packages to be used from unstable channel.
          (final: prev: { inherit (channels.unstable) discord; })
        ];
      };
      channels.unstable.input = nixos-unstable;

      ####################
      ### hostDefaults ###
      ####################

      hostDefaults = {
        # Default architecture to be used for `hosts` defaults to "x86_64-linux".
        system = "x86_64-linux";

        # Default modules to be passed to all hosts.
        modules = [
          ./users
          ./system/core
          utils.nixosModules.saneFlakeDefaults
          nixos.nixosModules.notDetected
        ];
      };

      ######################
      ### hosts - ceres ###
      ######################

      hosts.ceres = {
        # Host specific configuration.
        modules = [
          ./machines/ceres
          ./system/desktop
          ./system/gaming
          ./system/virtualisation
        ];
      };
    };
}
