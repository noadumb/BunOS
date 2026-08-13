{ pkgs, ... }:
{
  home.packages = [
    pkgs.vlc
    pkgs.gimp3-with-plugins
    pkgs.obs-studio
#    pkgs.logseq
  ];
}
