{
  lib,
  pkgs,
  self,
  hostname,
  ...
}:
{
  home.packages = with pkgs; [
    nixfmt
    nixd
  ];
  
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        redhat.vscode-xml
        redhat.vscode-yaml
        joortheen.nix-ide
        thenuprojectcontributors.vscode-nushell-lang
        rust-lang.rust-analyzer
        leonardssh.vscord
      ];
    };
  };
}
