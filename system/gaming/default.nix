{
  config,
  lib,
  ...
}:
{
  options = {
    bunos.desktop.gaming = {
      enable = lib.mkEnableOption "gaming systems";
    };
  };

  config = {
    programs.steam = {
      enable = lib.mkIf config.bunos.desktop.gaming.enable true;
    };
  };
}
