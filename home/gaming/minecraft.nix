{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = with lib; {
    bunos.desktop.gaming.minecraft = {
      enable = mkEnableOption "add Minecraft launcher";
      package = mkPackageOption pkgs "Prism Launcher" { default = "prismlauncher"; };
    };
  };
  config =
    let
      cfg = config.bunos.desktop.gaming.minecraft;
    in
      {
        home.packages = lib.optional cfg.enable cfg.package;
      };
}
