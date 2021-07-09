{ ... }:

{
  services = {
    clamav = {
      daemon = {
        enable = true;
      };
      updater = {
        enable = true;
      };
    };

    fwupd = {
      enable = true;
    };
  };
}
