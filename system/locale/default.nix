{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = with lib; {
    bunos.desktop.input = {
      fcitx = {
        enable = mkEnableOption "fcitx5";
      };
    };
  };

  config =
    let
      plasmaEnabled = config.services.desktopManager.plasma6.enable;
    in
    {
      time.timeZone = lib.mkDefault "Europe/Vienna";
      i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
        extraLocales = [
          "C.UTF-8/UTF-8"
          "en_GB.UTF-8/UTF-8"
          "de_DE.UTF-8/UTF-8"
          "de_AT.UTF-8/UTF-8"
        ];
      };

      console = lib.mkDefault {
        earlySetup = true;
        font = "Lat2-Terminus16";
        keyMap = "us";
        useXkbConfig = false;
      };

    };
}
