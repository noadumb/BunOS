{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  config = lib.mkIf osConfig.services.desktopManager.plasma6.enable {
    home.packages = with pkgs; [
      kdePackages.ktorrent
    ];

    programs.plasma = {
      enable = true;

      input = {
        keyboard = {
          layouts = [
            {
              layout = "us";
              variant = "qwerty";
            }
          ];
        };
      };
    };
  };

}
