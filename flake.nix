{
  description = "My NixOS configuration";

  inputs = {
    # NixOS / Packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Flake Utils Plus
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
  };

  outputs = inputs@{ self, nixpkgs, utils }:
    utils.lib.systemFlake {
      inherit self inputs;

      # Supported systems, used for packages, apps, devShell and multiple other definitions..
      supportedSystems = [ "x86_64-linux" ];


      ################
      ### channels ###
      ################

      # Configuration that is shared between all channels.
      channelsConfig = { allowUnfree = true; };

      # Overlays which are applied to all channels.
      sharedOverlays = [ ];

      # Specific channel configuration
      channels.nixpkgs = {
        # Nixpkgs flake reference to be used in the configuration.
        input = nixpkgs;

        # Channel specific config options.
        config = { };

        # Patches to apply on selected channel.
        patches = [ ];

        # Overlays to apply on a selected channel.
        overlaysBuilder = channels: [
          # (final: prev: { inherit (channels.unstable) neovim; })
        ];
      };

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
          nixpkgs.nixosModules.notDetected
        ];

        # Reference to `channels.<name>.*`, defines default channel to be used by hosts. Defaults to "nixpkgs".
        channelName = "nixpkgs";

        # Extra arguments to be passed to all modules. Merged with host's extraArgs.
        extraArgs = { };
      };

      ######################
      ### hosts - ceres ###
      ######################

      hosts.ceres = {
        # Extra arguments to be passed to the modules.
        extraArgs = { };

        # These are not part of the module system, so they can be used in `imports` lines without infinite recursion.
        specialArgs = { };

        # Host specific configuration.
        modules = [
          ./machines/ceres
          ./system/desktop
          ./system/gaming
          ./system/virtualisation
        ];

        # Flake output for configuration to be passed to. Defaults to `nixosConfigurations`.
        output = "nixosConfigurations";
      };
    };
}
