{ pkgs,
  ...
}:
{
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
  };

  environment.systemPackages = with pkgs; [
    tcpdump
  ];

  networking = {
#    nameservers = [
#      "8.8.8.8"
#      "1.1.1.1"
#      "1.0.0.1"
#      "8.8.4.4"
#    ];
    nat = {
      enable = true;
      internalInterfaces = [ "eth0" ];
      externalInterface = "wlan0";
    };

    interfaces.eth0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "10.42.0.1";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.0.1";
    networkmanager.unmanaged = [ "eth0" ];
  };
  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "eth0";
      bind-interfaces = true;
      dhcp-range = [ "10.42.0.10,10.42.0.100,12h" ];
      dhcp-option = [
        "option:router,10.42.0.1"
        "option:dns-server,10.42.0.1"
      ];
      server = [ "8.8.8.8" "8.8.4.4" ];
    };
  };
  networking.firewall.extraCommands = ''
    # Set up SNAT on packets going from downstream to the wider internet
    iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

    # Accept all connections from downstream. May not be necessary
    iptables -A INPUT -i eth0 -j ACCEPT
  '';
  networking.firewall.interfaces.eth0 = {
    allowedUDPPorts = [ 53 67 ];
    allowedTCPPorts = [ 53 ];
  };
}
