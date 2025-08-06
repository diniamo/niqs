{ lib, pkgs, ... }: let
  inherit (lib) getExe;
in {
  custom.git = {
    enable = true;

    settings = {
      user = {
        email = "diniamo53@gmail.com";
        name = "diniamo";
      };

      init.defaultBranch = "main";
      branch.autoSetupMerge = true;
      pull.ff = "only";
      diff.external = getExe pkgs.difftastic;

      push = {
        default = "current";
        autoSetupRemote = true;
        followTags = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
      };
    };

    ignores = ''
      .direnv/
      .cache/
    '';
  };
}
