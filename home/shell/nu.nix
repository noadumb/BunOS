{
  lib,
  pkgs,
  ...
}:
{
  home.shell.enableNushellIntegration = true;
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      formats
      query
      polars
    ];
    extraConfig = ''
      def within [w: duration] {
        (date now) + $w
      }
    '';
  };
}
