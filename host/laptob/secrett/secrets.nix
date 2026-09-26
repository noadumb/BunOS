let
  noelle = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJArLSovK+fQbv00gGOGhCAyRdxs3R9oz0fnfHb1yv3E noelle@laptob";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXvY4tV6uk0wKerkRHLhoqjZa+XLxiBGRQjSVwIJ+7F root@laptob"; #TODO change

  k = [
    noelle
    system
  ];

  make =
    x:
    builtins.listToAttrs (
      map (e: {
        name = e;
        value = {
          publicKeys = k;
        };
      }) x
    );
in
make [
  "noelle.age"
  "root.age"
  "sync.age"
  "synck.age"
  "irc.age"
  "tailscale.age"
]
