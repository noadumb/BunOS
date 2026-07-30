{
  config,
  pkgs,
  lib,
  lazyvim,
  programs,
  inputs,
  ...
}:
{
  imports = [
    ../../home
    lazyvim.homeManagerModules.default
  ];

  home.username = "noa";
  home.homeDirectory = "/home/noa";

  home.stateVersion = "26.05";
  
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
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

  programs.lazyvim = {
      enable = true;
      
      installCoreDependencies = true;

      extras = {
        lang.nix.enable = true;
        lang.python = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
          };
        lang.rust.enable = true;
        };
      extraPackages = with pkgs; [
      nixd
      alejandra
      yaml-language-server
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
