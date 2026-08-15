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

      python313Packages = p.python313Packages.overrideScope (
        pyFinal: pyPrev: {
          nanoemoji = pyPrev.nanoemoji.overrideAttrs (_: {
            src = f.fetchFromGitHub {
              owner = "googlefonts";
              repo = "nanoemoji";
              rev = "ba8cbc8dae6324d5a24fc67b068f8a7d08e49b7c";
              hash = "sha256-FysyKC01XBnRiur5RR9fcsTxQqE8x0JJHSoe3q6JtKc="; #TODO: figure out wtf this is
            };
          });
        }
      );
    })
  ];
}
