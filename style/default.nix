{ inputs, ... }:
{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];
  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };
}
