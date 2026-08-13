{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tldr
    choose
    procs
    rustscan
    xh
    duf
    dust
    trashy
    gping
    cheat
    nurl
    libqalculate
    ripgrep
    (uutils-coreutils.override { prefix = ""; })
    yt-dlp
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = false;
    maintenance.enable = true;
    signing = {
      key = "C782CD1F1A36850B";
      signByDefault = true;
    };
    settings = {
      user = {
        email = "noa.magic2006@gmail.com";
        name = "noelle";
      };
      push = { autoSetupRemote = true; };
    };
  };
  programs.pay-respects = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    options = [
      "--alias"
      "f"
    ];
  };

  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep-all;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    colors = "auto";
    git = true;
    icons = "auto";
  };

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
      prettybat
    ];
  };

  programs.fd = {
    enable = true;
  };
  programs.lazygit = {
    enable = true;
  };
  programs.jq = {
    enable = true;
  };
}
