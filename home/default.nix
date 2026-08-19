{
  lib,
  user,
  ...
}:
{
  imports = [
    ./browsers
    ./terminal
    ./dev
    ./gaming
    ./im
    ./media
    ./net
    ./office
    ./shell
    ./plasma.nix
    ./tracking
  ];





  home.language = lib.mkDefault {
    base = "en_US.UTF-8";
    numeric = "en_US.UTF-8";
    time = "en_US.UTF-8";
    collate = "en_US.UTF-8";
    monetary = "de_DE.UTF-8";
    messages = "en_US.UTF-8";
    paper = "de_DE.UTF-8";
    name = "de_DE.UTF-8";
    address = "de_DE.UTF-8";
    telephone = "de_DE.UTF-8";
    measurement = "en_US.UTF-8";
  };

  xdg.configFile."fontconfig/conf.d/10-hm-fonts.conf".force = true;

  programs.nh.enable = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/noa/config";
  };
  manual = {
    manpages.enable = true;
    json.enable = true;
  };
  news.display = "notify";
  home.stateVersion = "26.05";
  home.username = user;
}
