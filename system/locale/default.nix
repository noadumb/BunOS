{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = with lib; {
    bunos.desktop.input = {
      fcitx = {
        enable = mkEnableOption "fcitx5";
      };
    };
  };

  config =
    let
      plasmaEnabled = config.services.desktopManager.plasma6.enable;
    in
    {
      time.timeZone = lib.mkDefault "Europe/Vienna";
      i18n = {
        defaultLocale = lib.mkDefault "en_US.UTF-8";
        extraLocales = [
          "C.UTF-8/UTF-8"
          "en_GB.UTF-8/UTF-8"
          "de_DE.UTF-8/UTF-8"
          "de_AT.UTF-8/UTF-8"
        ];
      };

      console = lib.mkDefault {
        earlySetup = true;
        font = "Lat2-Terminus16";
        keyMap = "us";
        useXkbConfig = false;
      };

      i18n.inputMethod =
        if config.bunos.desktop.input.fcitx.enable then
          {
            enable = true;
            type = "fcitx5";
            fcitx5 = {
               waylandFrontend = true;
               addons =
                with pkgs;
                [
                  fcitx5-mozc
                  fcitx5-nord
                ]
                ++ lib.optional plasmaEnabled kdePackages.fcitx5-qt;

              quickPhrase = {
                pls = "👉👈🥺";
	              pld = "🥺";
              };
            };
          }
        else
          { };
      security.sudo = {
        enable = true;
        package = (pkgs.sudo.override { withInsults = true; }).overrideAttrs (old: {
          postPatch =
            (old.postPatch or "")
              + ''
	              substituteInPlace plugins/sudoers/logging.c \
	              --replace "This incident has been reported to the administrator." "uwu you g-got youwseww into a twoubwwe :333" \
	              --replace "incorrect password attempts" "uwuless passwowd twieww ~ >.< ~" \
	              --replace "incorrect password attempt" "uwuless passwowd twieww 🏳️‍⚧️ :3" \
	              --replace "authentication failure" "bad awwthweww uwu" \
	              --replace "a password is required" "wheww is my pawsome pawwwowd 🙏 \n"
	            '';
          configureFlags =
            (builtins.filter (x: !(lib.strings.hasPrefix x "--with-passprompt=")) old.configureFlags)
            ++ [
              "--with-badpass-message=bad paw-wowd 🥺🥺🍞"
	            "--with-passprompt=paw-wowd? 🥺"
            ];
        });
      };
    };
}
