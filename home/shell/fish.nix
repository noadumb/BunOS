{
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    bat
    grc
    fortune
    lolcat
    charasay
  ];

  programs.fd.enable = lib.mkForce true;

  programs.fzf = {
    enable = lib.mkForce true;
    enableFishIntegration = lib.mkForce false;
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;
    functions = {
      fish_greeting = {
        description = "Greeting to show when starting a fish shell";
        body = "fortune | lolcat -f | chara say -c kitten";
      };
    };
/*    interactiveShellInit = ''
      set fish_greeting
    ''; */

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
