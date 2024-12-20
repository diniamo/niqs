{
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) fetchFromGitHub;
  inherit (lib) mkOption types;

  sources = {
    bufresize-nvim = {
      pname = "bufresize.nvim";
      version = "2022-03-21";

      outPath = fetchFromGitHub {
        owner = "kwkarlwang";
        repo = "bufresize.nvim";
        rev = "3b19527ab936d6910484dcc20fb59bdb12322d8b";
        hash = "sha256-6jqlKe8Ekm+3dvlgFCpJnI0BZzWC3KDYoOb88/itH+g=";
      };

      passthru.vimPlugin = false;
    };
    direnv-nvim = {
      pname = "direnv.nvim";
      version = "2024-07-08_1";

      outPath = fetchFromGitHub {
        owner = "NotAShelf";
        repo = "direnv.nvim";
        rev = "3e38d855c764bb1bec230130ed0e026fca54e4c8";
        hash = "sha256-nWdAIchqGsWiF0cQ7NwePRa1fpugE8duZKqdBaisrAc=";
      };

      passthru.vimPlugin = false;
    };
    fastaction-nvim = {
      pname = "fastaction.nvim";
      version = "2024-07-19";

      outPath = fetchFromGitHub {
        owner = "Chaitanyabsprip";
        repo = "fastaction.nvim";
        rev = "886e22d85e13115808e81ca367d5aaba02d9a25b";
        hash = "sha256-1GSxTyXqufjkRtNK3drWlCn/mGJ9mM9bHMR6ZwWT6X8=";
      };

      passthru.vimPlugin = false;
    };
  };
in {
  options = {
    programs.nvf.custom.sources = mkOption {
      type = types.attrs;
      default = sources;
      readOnly = true;
      description = "External plugin sources";
    };
  };
}
