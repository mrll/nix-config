{ pkgs, ... }:

with pkgs;

let
  devPkgs = [
    direnv
    gitAndTools.gitFull
    git-crypt
    nixpkgs-fmt
  ];
  filePkgs = [
    gnutar
    ranger
    unrar
    unzip
    xz
    zip
  ];
  mediaPkgs = [
    playerctl
    imagemagick
  ];
  miscPkgs = [
    neofetch
  ];
  securityPkgs = [
    gopass
    pass
  ];
  toolsPkgs = [
    bat
    bandwhich
    bottom
    du-dust
    exa
    fd
    fzf
    procs
    ripgrep
    sd
    starship
    tealdeer
    zoxide
  ];
  webPkgs = [
    curl
    gnupg
    nmap
    rsync
    w3m
    wireshark-cli
    wget
  ];
in
{
  programs.vim.defaultEditor = true;

  environment.systemPackages =
    devPkgs
    ++ filePkgs
    ++ mediaPkgs
    ++ miscPkgs
    ++ securityPkgs
    ++ toolsPkgs
    ++ webPkgs;
}
