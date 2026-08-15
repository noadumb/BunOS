{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  options = with lib; {
    bunos.desktop.customization.kde = {
      wallpaper = {
        path = mkOption {
          type = types.nullOr types.path;
          description = "the wallpaper path to select";
          default = null;
        };
      };
    };
  };
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
        wallpaper = config.bunos.desktop.customization.kde.wallpaper.path;
      };

      hotkeys.commands."launch-kitty" = {
        name = "Launch Kitty";
        key = "Meta + K";
        command = "kitty";
      };

      #add shortcuts and stuffs
      shortcuts = {
        ksmserver = {
          "Halt Without Confirmation" = "none,Shut Down Without Confirmation";
          "Lock Session" = [
            "Screensaver"
            "Meta+L"
            "Meta+Ctrl+Alt+L,Meta+L"
            "Screensaver,Lock Session"
          ];
          "Log Out" = "Ctrl+Alt+Del";
        };

      };

    };
    services.kdeconnect.enable = true;
  };
}
