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
          switchingPolicy = "global";
          options = [
            "compose:caps"
          ];
        };
      };

      workspace = {
        enableMiddleClickPaste = false;
        clickItemTo = "select";
        theme = "Scratchy";
        colorScheme = "Scratchy";
        cursorTheme = "Sweet-cursors";
        iconTheme = "candy-icons";
        windowDecorations = {
          library = "org.kde.breeze";
          theme = "Breeze"; #mayb change all these to catpuccin at some point
        };
      };

      hotkeys.commands."launch-kitty" = {
        name = "Launch Kitty";
        key = "Meta + K";
        command = "kitty";
      };

      #add shortcuts and stuffs


    };
    services.kdeconnect.enable = true;
  };
}
