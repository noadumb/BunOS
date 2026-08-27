{ lib, pkgs, ... }:
{
  programs.firefox = {
    enable = true;


/*    settings = {

      "webgl.disabled" = false;
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    }; */
  };
}
