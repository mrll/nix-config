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
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "disk" "plugdev" "libvirtd" "docker" ];
    hashedPassword = fileContents ./secrets/mrll.hash;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [ ./secrets/ssh.pub ];
  };

  # --------------------------------------------------------------------------
  # dotfiles
  # --------------------------------------------------------------------------

  system.activationScripts = {
    mrll-dotfiles.text = ''
      export LINK=/run/current-system/sw/bin/ln
      export MKDIR=/run/current-system/sw/bin/mkdir
      export CHOWN=/run/current-system/sw/bin/chown
      export DOTFILE_DIR=/etc/nixos/users/mrll/secrets
      export USER_DIR=${config.users.users.mrll.home}

      # create directories
      $MKDIR -p $USER_DIR/.config
      $MKDIR -p $USER_DIR/.config/alacritty
      $MKDIR -p $USER_DIR/.config/Code/User
      $MKDIR -p $USER_DIR/.config/i3
      $MKDIR -p $USER_DIR/.config/rofi

      # link $HOME files
      $LINK -Tfs $DOTFILE_DIR/gitconfig        $USER_DIR/.gitconfig
      $LINK -Tfs $DOTFILE_DIR/background-image $USER_DIR/.background-image

      # link $HOME/.config folders
      $LINK -fs $DOTFILE_DIR/config/autorandr  $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/config/gtk-3.0    $USER_DIR/.config/
      $LINK -fs $DOTFILE_DIR/config/gtk-4.0    $USER_DIR/.config/

      # link $HOME/.config files
      $LINK -Tfs $DOTFILE_DIR/config/Code/User/settings.json $USER_DIR/.config/Code/User/settings.json

      # link files from /etc
      $LINK -fs /etc/i3/config                  $USER_DIR/.config/i3/config
      $LINK -fs /etc/alacritty/alacritty.yml    $USER_DIR/.config/alacritty/alacritty.yml
      $LINK -fs /etc/rofi.rasi                  $USER_DIR/.config/rofi/config.rasi

      # update owner & group
      $CHOWN ${config.users.users.mrll.name}:${config.users.users.mrll.group} $USER_DIR/.config
      $CHOWN ${config.users.users.mrll.name}:${config.users.users.mrll.group} $USER_DIR/.config/alacritty
      $CHOWN ${config.users.users.mrll.name}:${config.users.users.mrll.group} $USER_DIR/.config/Code/User
      $CHOWN ${config.users.users.mrll.name}:${config.users.users.mrll.group} $USER_DIR/.config/i3
      $CHOWN ${config.users.users.mrll.name}:${config.users.users.mrll.group} $USER_DIR/.config/rofi
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
