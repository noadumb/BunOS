{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.desktopManager.plasma6.enable = lib.mkIf config.bunos.desktop.display.manager.plasma.enable true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    kmail
    oxygen
  ];

  environment.systemPackages = with pkgs.kdePackages; [
    kdepim-addons
    akonadi-calendar
  ];

  programs.kde-pim = {
    enable = true;
    kmail = false;
    kontact = false;
    merkuro = true;
  };
}
