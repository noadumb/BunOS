let
  noelle = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsU9kEzxPGxvU54YaNFhCDcgdWYlEDF+3k8QnUlmSXP noelle@kibity";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBwWhmvaCSI8GT8hNK+WezwVvtln+kzxipOVtdJH/l6v root@kibity";

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
