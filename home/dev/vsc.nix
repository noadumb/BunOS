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
        editorconfig.editorconfig
      ];
      userSettings = {

        "editorconfig.generateauto" = false;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "nixfmt";
        "nix.serverSettings" = {
          nixd = {
            formatting.command = [ "nixfmt" ];
            options =
              let
                nixopts = "(builtins.getFlake \"${self.outPath}\").nixosConfigurations.${hostname}.options";
              in
                {
                  nixos.expr = nixopts;
                  home-manager.expr = nixopts + ".home-manager.users.type.getSubOptions []";
            };
          };
        };
      };
    };
  };
}
