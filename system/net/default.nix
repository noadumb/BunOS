{
  hostname,
  config,
  lib,
  ...
}:
{
  options = with lib; {
    bunos.net.ssh = {
      enableJump = mkEnableOption "enable jump-server specific config";
    };
  };
  config =
    let
      cfg = config.bunos.net.ssh;
    in
    {
      networking.hostName = "${hostname}";
      networking.networkmanager.enable = true;
      networking.wireless.enable = true; #not sure if needed? maybe somewhere else

      services.fail2ban = {
        enable = false;
        maxretry = 7;
        ignoreIP = [
          "10.0.0.0/8"
          "172.16.0.0/12"
          "192.168.0.0/16" #idk if corect?
        ];
        bantime = "3h";
      };

      services.openssh = {
        enable = true;
        ports = [ 6969 ];
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = true;
          PubkeyAuthentication = true;
          TCPKeepAlive = false;
          MaxSessions = 2;
          ClientAliveCountMax = 2;
          MaxAuthTries = 3;
          AllowTcpForwarding = cfg.enableJump;
          AllowAgentForwarding = cfg.enableJump;
          LogLevel = "VERBOSE";
        };
      };

      networking.firewall.enable = false;
    };
}
