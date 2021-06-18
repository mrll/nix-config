{ ... }:

{
  imports = [
    # Wifi Access Points & PSK
    ./secrets/wifi_networks.nix
    # Configuration
    ./audio.nix
    ./bluetooth.nix
    ./locale.nix
    ./misc.nix
    ./network.nix
    ./packages.nix
    ./shells.nix
    ./upower.nix
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
  boot.plymouth.enable = true;
  system.stateVersion = "20.09";
}
