{
  lib,
  config,
  ...
}:
{
  options = with lib; {
    bunos.net.syncthing = {
      enable = mkEnableOption "enable syncthing";
      cert = mkOption {
        type = types.path;
        description = "syncthing cert path";
      };
      key = mkOption {
        type = types.path;
        description = "syncthing key path";
      };
    };
  };
  config = lib.mkIf config.bunos.net.syncthing.enable {
    services = {
      syncthing = {
        enable = true;
        cert = config.bunos.net.syncthing.cert;
        key = config.bunos.net.syncthing.key;
      };
    };
    systemd.user.services.syncthing.Service.Environment = "\"STNODEFAULTFOLDER=true\"";
  };
}
