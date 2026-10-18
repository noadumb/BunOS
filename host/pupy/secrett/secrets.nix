let
  noelle = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0krCMVzoBQWbtKxK80Zgb8bapwrhDN1ww6riiWD1/O noelle@pupy";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHuP4OgfIuRTaIBS5Rns5/pvkCP9sVhpDgv4vtzrZiB7 root@pupy";

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
