{
  pkgs,
  lib,
  self,
  ...
}:

{
  imports = [
    ./boot
    ./net
    ./de
    ./gaming
  ];

#  nix.package = pkgs.lix; //ENABLE LATER

  environment.systemPackages = with pkgs; [
    bash
    fish
    curl
    git
    bat
    hyfetch
    whois
    lsof
    pciutils
    nix-output-monitor
    nix-search-cli
  ];

  programs = {
    htop = {
      enable = true;
      package = pkgs.btop;
    };
    fish = {
      enable = true;
      useBabelfish = true;
    };
    mtr.enable = true;
    iotop.enable = true;
    less = {
      enable = true;
    };
    tmux = {
      enable = true;
      shortcut = "a";
    };
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };
    command-not-found.enable = false;
    nix-index.enable = true;
  };

  nix.gc = {
    automatic = lib.mkDefault false;
    dates = lib.mkDefault "21:37";
    options = lib.mkDefault "--delete-older-than 3d";
    persistent = lib.mkDefault true;
  };

  nix.optimise = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault [ "22:15" ];
  };

  documentation = lib.mkDefault {
    enable = true;
    nixos = {
      enable = true;
      includeAllModules = true;
    };
  };

  users.defaultUserShell = pkgs.fish;
  
  system.nixos = {
    distroName = lib.mkForce "BunOS";
    distroId = lib.mkForce "bunos";
    label = "${self.shortRev or self.dirtyShortRev}";
    revision = lib.mkForce "${self.shortRev or self.dirtyShortRev}";
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = lib.mkDefault false;
  systemd.oomd.enable = true;
  boot.kernel.sysctl."kernel.sysrq" = lib.mkDefault 1;

  system.stateVersion = "26.05";
}
