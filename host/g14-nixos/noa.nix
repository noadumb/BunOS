{
  config,
  pkgs,
  lib,
  programs,
  inputs,
  ...
}:
{
  imports = [
    ../../home
  ];









  home.packages = with pkgs; [
    vesktop
    vlc
    sops
    age
    heroic
    hydralauncher
    vscodium
    vesktop #change to discord package with vencord overlay
    kdePackages.kate
    telegram-desktop
    signal-desktop
    tor-browser
    tealdeer
    krita
    spotify #change to idk spotifyd at some point

    ];

#   android_sdk.accept_license = true;

  programs.thunderbird = {
    enable = true;
  };


  programs.firefox = {
    enable = true;
  };

  programs.nushell = {
    enable = true;
  };

/*  bunos.net.syncthing = {
    enable = true;
#    cert =
#    key =  # LATER
  }; */



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




  programs.neovim.defaultEditor = true;

/*  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/noa/config";
  }; */
}
