{
  config,
  lib,
  pkgs,
  ...
}:


{
  imports = [
    ./kde.nix
  ];

  options = with lib; {
    bunos.desktop.display = {
      xorg = {
        enable = mkEnableOption "xorg system";
      };
      wayland = {
        enable = mkEnableOption "wayland system";
      };

      manager = {
        plasma = {
          enable = mkEnableOption "plasma 6";
        };
        hyprland = {
          enable = mkEnableOption "hyprland";
        };
      };
    };
  };
  config = {
    bunos.desktop.display.wayland.enable = lib.mkDefault true;

    services.displayManager.autoLogin.user = "noa";
    services.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      wayland = lib.mkIf config.bunos.desktop.display.wayland.enable {
        compositor = if config.bunos.desktop.display.manager.plasma.enable then "kwin" else "weston";
        enable = true;
      };
    };

    environment.sessionVariables = lib.mkIf config.bunos.desktop.display.wayland.enable {
      NIXOS_OZONE_WL = 1;
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "intl";
      options = "";
    };

    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    services.libinput.enable = true;

    environment.systemPackages = [ pkgs.kitty ];
  };
}
