{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = lib.mkDefault "Fira Code";
    };
  };
}
