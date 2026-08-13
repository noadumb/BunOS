{
  lib,
  user,
  ...
}:
{
  imports = [
    ./browsers
    ./dev
    ./gaming
    ./im
    ./media
    ./net
    ./office
    ./shell
    ./plasma.nix
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

  programs.nh.enable = true;
  manual = {
    manpages.enable = true;
    json.enable = true;
  };
  news.display = "notify";
  home.stateVersion = "26.05";
  home.username = user;
}
