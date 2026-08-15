let
  noa = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILtH0Rp4e9J45U6gJ8aeBVP2j1kPEPl18tHrEFKMLPUG noa.magic2006@gmail.com";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIABInqPbQ3iVzAu6gTAthL/G5YFGK2oxQWFZXZUmBrqm root@g14-nixos";

  k = [
    noa
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
  "noa.age"
  "root.age"
  "sync.age"
  "synck.age"
  "irc.age"
]
