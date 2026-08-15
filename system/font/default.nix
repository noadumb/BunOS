{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = with lib; {
    bunos.desktop.fonts = {
      useDefault = mkOption {
        default = true;
        example = true;
        type = types.bool;
        description = "whether to use the default fonts.";
      };
    };
  };
  config = {
    fonts.packages =
      with pkgs;
      lib.mkIf config.bunos.desktop.fonts.useDefault [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        ibm-plex
        times-newer-roman
        roboto
        comic-relief
        comic-neue
        open-dyslexic
        liberation_ttf
        twitter-color-emoji
        fira-code
        comic-mono
        jetbrains-mono
        monaspace
        victor-mono
        nerd-fonts.symbols-only
        vegur

      ];

    fonts.fontconfig = {
      enable = true;
      hinting = lib.mkDefault {
        enable = true;
        style = "medium";
      };
      antialias = true;
      allowBitmaps = true;
      useEmbeddedBitmaps = true;
      defaultFonts = lib.mkIf config.bunos.desktop.fonts.useDefault {
        serif = [
          "Noto Serif"
          "Symbols Nerd Font"
        ];
        sansSerif = [
          "Noto Sans"
          "Symbols Nerd Font"
        ];
        monospace = [
          "Fira Code"
          "Symbols Nerd Font Mono"
        ];
        emoji = [
          "Twitter Color Emoji"
          "Symbols Nerd Font"
        ];
      };
    };
  };
}
