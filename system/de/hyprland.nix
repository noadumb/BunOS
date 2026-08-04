{
  config,
  lib,
  ...
}:

{
  programs.hyprland.enable = lib.mkIf config.bunos.desktop.display.manager.hyprland.enable true;
}
