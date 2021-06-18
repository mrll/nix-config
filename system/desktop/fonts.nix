{ pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      fira
      fira-code
      merriweather
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      powerline-fonts
    ];
    fontconfig.defaultFonts = {
      monospace = [ "FiraCode Nerd Font" ];
      serif = [ "Merriweather" ];
      sansSerif = [ "Fira Sans Pro" ];
    };
  };
}
