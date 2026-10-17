{
  inputs,
  lib,
  ...
}:
{
  imports = [
    ../../home
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };

  programs.senpai.enable = lib.mkForce false;
}
