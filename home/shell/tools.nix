{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tldr
    choose
    procs
    doggo
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

/*  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent = {
    enable = true;
  }; */

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = false;
    maintenance.enable = true;
    signing = {
      key = "/home/noelle/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      gpg.format = "ssh"; #TODO: check
      user = {
        email = "noa.magic2006@gmail.com";
        name = "noelle";
      };
      push = { autoSetupRemote = true; };
        credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
          }/bin/git-credential-libsecret";

    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "noa.magic2006@gmail.com";
        name = "noelle";
      };
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
