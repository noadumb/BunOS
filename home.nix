{ config, pkgs, programs, inputs, ... }:

{
  home.username = "noa";


  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop
    vesktop
    vlc
    sops
    age
    heroic
    hydralauncher
    vscodium
  ];
  programs.firefox = {
    enable = true;
  };


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

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/noa/config";
  };
}
