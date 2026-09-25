{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  boot.extraModprobeConfig = ''
    options mt7925e disable_aspm=1
    options mt7925e power_save=0

    options mt7925-common disable_clc=1
  '';

  networking.networkmanager.wifi = {
    powersave = false;
    scanRandMacAddress = false;
  };

  systemd.services.mediatek-wifi-resume = {
    description = "Restart NetworkManager after suspend to fix MediaTek WiFi";
    wantedBy = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    after = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl restart NetworkManager.service";
    };
  };

  hardware.enableAllFirmware = true;
  networking.networkmanager.wifi.backend = "iwd";
#  networking.wireless.enable = false;
  networking.wireless.iwd.settings = {
    General = {
      AddressRandomization = "network";
      EnableNetworkConfiguration = false;
    };
    Settings = {
      AutoConnect = true;
    };
  };
}
