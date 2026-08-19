let
  noelle = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILtH0Rp4e9J45U6gJ8aeBVP2j1kPEPl18tHrEFKMLPUG noa.magic2006@gmail.com";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIABInqPbQ3iVzAu6gTAthL/G5YFGK2oxQWFZXZUmBrqm root@buni";

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
