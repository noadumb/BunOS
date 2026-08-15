{ pkgs, ... }:
{
  home.packages = with pkgs; [ element-desktop cinny-desktop];
}
