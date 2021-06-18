{ config, ... }:

{
  networking = {
    networkmanager.enable = false;

    wireless = {
      enable = true;
      userControlled.enable = true;
    };

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
