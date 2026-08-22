{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    jetbrains.clion
    gcc
    gdb
    cmake
    gnumake
    ninja
    clang-tools
    nix-ld
  ];
/*  options = with lib; {
    bunos.desktop.dev = {
      jetbrains = {
        enable = mkEnableOption "jetbrains programs";
      };
    };
  };
  config = lib.mkIf config.bunos.dev.jetbrains.enable {
    jetbrains = {
      enable = true;
    }; TODO: fix pls
  }; */
}
