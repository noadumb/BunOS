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
      kdePackages.ffmpegthumbs
      kdePackages.kdegraphics-thumbnailers
      kdePackages.kdbusaddons
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
          "Halt Without Confirmation" = "none,,Shut Down Without Confirmation";
          "Lock Session" = [
            "Screensaver"
            "Meta+L"
            "Meta+Ctrl+Alt+L,Meta+L"
            "Screensaver,Lock Session"
          ];
          "Log Out" = "Ctrl+Alt+Del";
        };
        kwin = {
          "Expose" = "Meta+,";
          "Switch Window Down" = [ ];
          "Switch Window Left" = [ ];
          "Switch Window Right" = [ ];
          "Switch Window Up" = [ ];
        };
      };
      configFile = {
        "baloofilerc"."Basic Settings"."Indexing-Enabled" = true;
        "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "SF";

        "kwinrc"."Wayland"."InputMethod[$e]" =
          "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";

        "spectaclerc"."General"."autoSaveImage" = true;
        "spectaclerc"."General"."clipboardGroup" = "PostScreenshotCopyImage";
        "spectaclerc"."General"."launchAction" = "UseLastUsedCapturemode";
        "spectaclerc"."GuiConfig"."captureMode" = 0;

        "dolphinrc"."PreviewSettings"."Plugins" =
          "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,textthumbnail,ffmpegthumbs";
      };
    };

    services.kdeconnect.enable = true;
  };
}
