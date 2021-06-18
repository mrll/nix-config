{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = true;
      enableCompletion = true;

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [
          "direnv"
          "git"
          "gitignore"
          "man"
          "pass"
          "sudo"
          "zsh-interactive-cd"
        ];
      };
    };
  };

  environment = {
    shells = with pkgs; [ bash zsh ];
    shellAliases = {
      # bat
      cat = "bat";
      # exa
      ls = "exa --icons";
      ll = "ls -l";
      la = "ls -al";
      tree = "ls --tree";
      # procs
      ps = "procs";
      # zoxide
      zq = "zoxide query";
      cd = "z";
    };
  };
}
