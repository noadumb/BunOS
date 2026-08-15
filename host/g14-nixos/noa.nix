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
    tor-browser
    krita
    spotify #change to idk spotifyd at some point
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
#   android_sdk.accept_license = true;

/*  programs.thunderbird = {
    enable = true;
  }; */


/*  programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  }; */ # moved to browsers directory

/*  programs.nushell = {
    enable = true;
  };

  bunos.net.syncthing = {
    enable = true;
#    cert =
#    key =  # LATER
  }; */

/*

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

*/



/*  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/noa/config";
  }; */
}
