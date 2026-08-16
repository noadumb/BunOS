{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    jetbrains-toolbox
    jetbrains.clion
  ];
}
