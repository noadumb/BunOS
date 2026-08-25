{ ... }:
{
  services.adguardhome = {
    enable = true;
    host = "127.0.0.1";
    openFirewall = true;
    allowDHCP = true;
    settings = {
      http = {
        address = "0.0.0.0:3003";
      };
      dns = {
        upstream_dns = [
          "10.1.69.2"
          "9.9.9.9"
          "149.112.112.112"
        ];
        upstream_mode = "parallel";
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        parental_enabled = false;
        safe_search = {
          enabled = false;
        };
      };
      filters =
        map
          (url: {
            enabled = true;
            url = url;
          })
          [
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
          ];
    };
  };
}
