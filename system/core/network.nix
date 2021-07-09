{ config, ... }:

{
  imports = [
    # Wifi Access Points
    # ./secrets/wifi_networks.nix
  ];

  networking = {
    networkmanager.enable = true;

    #wireless = {
    #  enable = true;
    #  userControlled.enable = true;
    #};

    firewall = {
      enable = true;
    };
  };

  services.openssh = {
    enable = true;
    forwardX11 = config.services.xserver.enable;
    openFirewall = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };
}
