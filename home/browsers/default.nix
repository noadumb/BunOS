{ lib, pkgs, ... }:
{
  programs.librewolf = {
    enable = true;
    settings = lib.mkDefault {
      "webgl.disabled" = false;
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.cookies" = false;
    };
  };
}
