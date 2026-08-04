{ ... }:
{
  imports = [
    ./vsc.nix
    ./direnv.nix
    ./sec.nix
  ];

/*  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_style = "space";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
      };
      "*.{nix,js,ts,json}" = {
        indent_size = 2;
        indent_style = "space";
      };
      "*.{c,cc,cpp,cs,html,xml,csproj,py,go,rs,fish,sh,java}" = {
        indent_size = 4;
      };
      "*.md" = {
        trim_trailing_whitespace = false;
      };
    };
  };*/
}
