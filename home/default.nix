{
  lib,
  user,
  ...
}:
{
  imports = [
    ./dev
  ];

  

  home.language = lib.mkDefault {
    base = "en_US.UTF-8";
    numeric = "en_US.UTF-8";
    time = "de_DE.UTF-8";
    collate = "de_DE.UTF-8";
    monetary = "de_DE.UTF-8";
    messages = "en_US.UTF-8";
    paper = "de_DE.UTF-8";
    name = "de_DE.UTF-8";
    address = "de_DE.UTF-8";
    telephone = "de_DE.UTF-8";
    measurement = "de_DE.UTF-8";
  };

  programs.nh.enable = true;
  manual = {
    manpages.enable = true;
    json.enable = true;
  };
  home.stateVersion = "26.05";

}
