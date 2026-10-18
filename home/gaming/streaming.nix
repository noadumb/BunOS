{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = with lib; {
    bunos.desktop.gaming = {
      streaming = {
        enable = mkEnableOption "add sunshine for game streaming";
        package = mkPackageOption pkgs "Sunshine" { default = "sunshine"; };
      };
    };
  };
  config =
    let
      cfg = config.bunos.desktop.gaming.streaming;
    in
      {
        home.packages = lib.optional cfg.enable cfg.package;
      };
}
