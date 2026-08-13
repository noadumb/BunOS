{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    thunderbird
  ];
}
