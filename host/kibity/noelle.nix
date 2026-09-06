{
  osConfig,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ../../home
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.packages = with pkgs; [
    sops
    age
    heroic
    hydralauncher
    kdePackages.kate
    telegram-desktop
    signal-desktop
#    tor-browser
    krita
    spotify #change to idk spotifyd at some point
    motrix-next
    ];

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };

  programs.kitty.settings = {
    font_family = "Comic Code Ligatures";
    font_features = "+frac +liga +ordn +sinf";
  };

  bunos.net.syncthing = {
    enable = false;
    cert = osConfig.age.secrets.sync.path;
    key = osConfig.age.secrets.synck.path;
  };

  bunos.desktop.gaming.minecraft.enable = true;

  programs.senpai.config = {
    enable = false;
    nickname = "noelle";
#    password-cmd = [
#      "cat"
#      "${osConfig.age.secrets.irc.path}"
#    ];
  };

  services.recoll = {
    enable = false;
    # TODO SMTH IDK WRUF :3
  };

  systemd.user.services = {
    adjust-audio = {
      Unit = {
        Description = "adjust auwudio";
      };

      Install = {
        WantedBy = [ "wireplumber.service" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5";
      };
    };
  };

}
