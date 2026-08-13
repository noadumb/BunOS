{
  lib,
  pkgs,
  ...
}:
{
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      formats
      query
      polars
    ];
  };
}
