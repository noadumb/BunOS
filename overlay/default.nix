{
  inputs,
  system,
  pkgs,
  ...
}:
let
  pkgsu = inputs.nixpkgs-pkgs-unstable.legacyPackages.${system};
in
{
  nixpkgs.overlays = [
    (f: p: {
      librewolf-unwrapped = pkgsu.librewolf-unwrapped;
    })
  ];
}
