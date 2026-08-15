{
  pkgs,
  ...
}:
{
  services.activitywatch =
    let
      host = "127.0.0.1";
      port = 5600;
    in
    {
      enable = false;
      package = pkgs.aw-server-rust;
      settings = {
        host = host;
        port = port;
      };

      extraOptions = [
        "--host"
        host
        "--port"
        (builtins.toString port)
      ];

      watchers = {
        aw-watcher-afk = {
          package = pkgs.activitywatch;
          settings = {
            timeout = 300;
            poll_time = 2;
          };
          extraOptions = [
            "--port"
            (builtins.toString port)
          ];
        };
        awatcher = {
          package = pkgs.awatcher;
          settings = {
            server = {
              host = host;
              port = port;
            };
            poll_time = 1;
            exclude_title = true;
          };
        };
      };
    };
}
