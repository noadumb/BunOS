{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = lib.mkDefault "Fira Code";
      font_size = "13.0";

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = "never";

      cursor = "none";
      cursor_shape = "beam";
      cursor_beam_thickness = "1.3";

      selection_foreground = "none";
      selection_background = "#eeeeee";

      sync_to_monitor = "yes";
      confirm_os_window_close = 0;

      scrollback_lines = 2137;

      auto_reload_config = -1;

      symbol_map =
        let
          mappings = [
            "U+23FB-U+23FE"
            "U+2B58"
            "U+E200-U+E2A9"
            "U+E0A0-U+E0A3"
            "U+E0B0-U+E0BF"
            "U+E0C0-U+E0C8"
            "U+E0CC-U+E0CF"
            "U+E0D0-U+E0D2"
            "U+E0D4"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+2665"
            "U+26A1"
            "U+F400-U+F4A8"
            "U+F67C"
            "U+E000-U+E00A"
            "U+F300-U+F313"
            "U+E5FA-U+E62B"
          ];
        in
          lib.mkIf (lib.lists.any (x: x == pkgs.nerd-fonts.symbols-only) osConfig.fonts.packages) (
            (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font"
          );
    };

    shellIntegration = {
      enableFishIntegration = true;
      enableBashIntegration = true;
    };

    keybindings = {
      "ctrl+alt+u" = "kitten unicode_input";
    };
  };
}
