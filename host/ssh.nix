{
  pkgs ? import <nixpkgs> { },
  ...
}:
rec {

  hosts = {
    g14-nixos = {
      tags = [ "laptop" ];
      users = {
        noa = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILtH0Rp4e9J45U6gJ8aeBVP2j1kPEPl18tHrEFKMLPUG noa.magic2006@gmail.com"
        ];
      };
    };
  };

  getAllKeys = pkgs.lib.unique (
    pkgs.lib.flatten (map (host: getKeysFromHost host) (pkgs.lib.attrNames hosts))
  );

  getUsersFromHost =
    host:
    let
      users = hosts.${host}.users or (builtins.abort "cannot find host ${host}.");
    in
    pkgs.lib.attrNames users;

  getKeysFromHost =
    host: pkgs.lib.flatten (map (user: hosts.${host}.users.${user}) (getUsersFromHost host));
}
