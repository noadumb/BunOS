{ ... }:
{
  environment.persistence."/silly" = {
    enable = true;
    hideMounts = true;
    directories =
      map
        (
          x:
          if builtins.isPath x then
            toString x
          else if builtins.isAttrs x && x ? directory && builtins.isPath x.directory then
            x // { directory = toString x.directory; }
          else
            x
        )
        [
          {
            directory = /var/lib/nixos;
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = /var/lib/systemd;
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = /var/lib/sbctl;
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = /var/lib/auto-cryptenroll;
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = /var/lib/iwd;
            user = "root";
            group = "root";
            mode = "0700";
          }
          {
            directory = /etc/NetworkManager/system-connections;
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = /var/lib/NetworkManager;
            user = "root";
            group = "root";
            mode = "0755";
          }
          {
            directory = /var/lib/bluetooth;
            user = "root";
            group = "root";
            mode = "0700";
          }
          {
            directory = /etc/asusd;
            user = "root";
            group = "root";
            mode = "0755";
          }
          #wgnord
          {
            directory = /etc/wireguard;
            user = "root";
            group = "root";
            mode = "0700";
          }
          {
            directory = /var/lib/wgnord;
            user = "root";
            group = "root";
            mode = "0700";
          }
#          {
#            directory = /etc/rkvm;
#            user = "root";
#            group = "root";
#             mode = "0755";
#          }
        ];
        files = map toString [
          /etc/machine-id
          /etc/adjtime
          /etc/ssh/ssh_host_ed25519_key
          /etc/ssh/ssh_host_ed25519_key.pub
          /etc/ssh/ssh_host_rsa_key
          /etc/ssh/ssh_host_rsa_key.pub
        ];
  };
}
