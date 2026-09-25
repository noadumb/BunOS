{ ... }:
{
  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "eth0" ];
      externalInterface = "wlan0";
    };
    interfaces.eth0.ipv4.addresses = [{
      address = "10.42.0.1";
      prefixLength = 24;
    }];
    networkmanager.unmanaged = [ "eth0" ];
  };
  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "eth0";
      bind-interfaces = true;
      dhcp-range = "10.42.0.10,10.42.0.100,12h";
      dhcp-option = [
        "option:router,10.42.0.1"
        "option:dns-server,10.42.0.1"
      ];
    };
  };
  networking.firewall.interfaces.eth0 = {
    allowedUDPPorts = [ 53 67 ];
    allowedTCPPorts = [ 53 ];
  };
}
