{ ... }:

{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  time.timeZone = "Europe/Berlin";

  console.keyMap = "de";
  console.font = "Lat2-Terminus16";
}
