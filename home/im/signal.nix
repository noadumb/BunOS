{ pkgs, ... }:
{
  home.packages = [ pkgs.signal-desktop ];
  programs.gurk-rs = {
    enable = true;
    settings = {
      first_name_only = true;
      show_receipts = true;
      notifications = {
        enabled = false;
      };
      bell = false;
      colored_messages = true;
      default_keybindings = true;
      user = {
        name = "noelle";
      };
    };
  };
}
