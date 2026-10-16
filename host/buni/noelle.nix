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
    krita
    spotify #change to idk spotifyd at some point
    steam-run
    nur.repos.GriefNorth.ps5upload
    unrar-free
    ];

  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };

  programs.kitty.settings = {
    font_family = "Comic Code Ligatures";
    font_features = "+frac +liga +ordn +sinf";
  };

  bunos.net.syncthing = {
    enable = true;
    cert = osConfig.age.secrets.sync.path;
    key = osConfig.age.secrets.synck.path;
  };

  bunos.desktop.gaming.minecraft.enable = true;

  programs.senpai.config = {
    nickname = "noelle";
    password-cmd = [
      "cat"
      "${osConfig.age.secrets.irc.path}"
    ];
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
