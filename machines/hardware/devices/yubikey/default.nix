{ lib, config, pkgs, ... }:
let
  packages = with pkgs; if config.services.xserver.enable then [
    yubikey-manager
    yubikey-manager-qt
    yubioath-desktop
  ] else [
    yubikey-manager
  ];
in
{
  # --------------------------------------------------------------------------
  # services for yubikey
  # --------------------------------------------------------------------------

  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # --------------------------------------------------------------------------
  # packages
  # --------------------------------------------------------------------------

  environment.systemPackages = packages;

  # --------------------------------------------------------------------------
  # gpg & ssh via yubikey
  # --------------------------------------------------------------------------

  programs.ssh.startAgent = false;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  environment.shellInit = ''
    export GPG_TTY="$(tty)"
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  '';
}
