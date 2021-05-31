{ config, lib, pkgs, ... }:
let
  inherit (lib) fileContents;
in
{
  # --------------------------------------------------------------------------
  # user
  # --------------------------------------------------------------------------

  users.users.mrll = {
    createHome = true;
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "video" "audio" "disk" "plugdev" "libvirtd" "docker" ];
    hashedPassword = fileContents ./secrets/mrll.hash;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [ ./secrets/ssh.pub ];
  };

  # --------------------------------------------------------------------------
  # dotfiles
  # --------------------------------------------------------------------------

  system.activationScripts = {
    mrll-dotfiles.text = ''
      export LINK=${pkgs.coreutils}/bin/ln
      export MKDIR=${pkgs.coreutils}/bin/mkdir
      export DOTFILE_DIR=/etc/nixos/users/mrll/secrets/home
      export USER_DIR=/home/mrll

      # needed directories
      $MKDIR -p $USER_DIR/.config
      $MKDIR -p $USER_DIR/.config/Code/User

      # ~ files
      $LINK -Tfs $DOTFILE_DIR/.gitconfig        $USER_DIR/.gitconfig
      $LINK -Tfs $DOTFILE_DIR/.zshrc            $USER_DIR/.zshrc
      $LINK -Tfs $DOTFILE_DIR/.background-image $USER_DIR/.background-image


      # .config folder links
      $LINK -fs $DOTFILE_DIR/.config/alacritty  $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/autorandr  $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/dunst      $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/gtk-3.0    $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/i3         $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/nu         $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/polybar    $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/rofi       $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/rofi-pass  $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/.config/starship   $USER_DIR/.config/

      # .config single file links
      $LINK -Tfs $DOTFILE_DIR/.config/Code/User/settings.json $USER_DIR/.config/Code/User/settings.json
    '';
  };

  # --------------------------------------------------------------------------
  # vscode extensions
  # --------------------------------------------------------------------------

  system.activationScripts = {
    fix-mrll-vscode-extensions =
      let
        vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./vscode/extensions.nix);
      in
      {
        text = ''
          EXT_DIR=${config.users.users.mrll.home}/.vscode/extensions
          rm -rf $EXT_DIR
          mkdir -p $EXT_DIR
          chown ${config.users.users.mrll.name}:${config.users.users.mrll.group} $EXT_DIR
          for x in ${lib.concatMapStringsSep " " toString vscodeExtensions}; do
              ln -sf $x/share/vscode/extensions/* $EXT_DIR/
          done
          chown -R ${config.users.users.mrll.name}:${config.users.users.mrll.group} $EXT_DIR
        '';
        deps = [ ];
      };
  };
}
