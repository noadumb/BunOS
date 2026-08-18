{
  inputs,
  ...
}:
{
  imports = [
    ../../home
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };
}
