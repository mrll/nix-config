{ ... }:

{
  imports = [
    # Wifi Access Points & PSK
    ./secrets/wifi_networks.nix
    # System Configuration
    ./audio.nix
    ./bluetooth.nix
    ./colors.nix
    ./locale.nix
    ./misc.nix
    ./network.nix
    ./packages.nix
    ./shells.nix
    ./upower.nix
    # Configuration Files
    ../config
  ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    allowedUsers = [ "@users" ];
    trustedUsers = [ "root" "@wheel" ];
  };
  nixpkgs.config.allowUnfree = true;

  boot.cleanTmpDir = true;
  system.stateVersion = "20.09";
}
