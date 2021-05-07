{ lib, ... }:
let
  inherit (lib) fileContents;
in
{
  # --------------------------------------------------------------------------
  # user
  # --------------------------------------------------------------------------

  users.users.root.hashedPassword = fileContents ./secrets/root.hash;
}
