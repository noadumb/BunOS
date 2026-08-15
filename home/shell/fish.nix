{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    bat
    grc
  ];

  programs.fd.enable = lib.mkForce true;

  programs.fzf = {
    enable = lib.mkForce true;
    enableFishIntegration = lib.mkForce false;
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;
    interactiveShellInit = ''
      set fish_greeting
    '';

    plugins =
      map
        (x: {
          name = lib.getName x;
          src = x.src;
        })
        (
          with pkgs.fishPlugins;
          [
            tide
            fzf-fish
            autopair
            z
            grc
          ]
        );
  };
}
