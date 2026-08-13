{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      # TODO WAAAAA
    };
  };

  environment.systemPackages = lib.mkIf config.bunos.desktop.display.wayland.enable [
    pkgs.wl-clipboard
  ];
}
