{
  config,
  lib,
  pkgs,
  ...
}:
{
/*  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      # TODO WAAAAA
    };
  }; */
  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };

  environment.systemPackages = lib.mkIf config.bunos.desktop.display.wayland.enable [
    pkgs.wl-clipboard
  ];
}
