{ lib, inputs, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
