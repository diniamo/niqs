{
  programs.git = {
    enable = true;

    userName = "diniamo";
    userEmail = "diniamo53@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";

      branch.autoSetupMerge = true;
      pull.ff = "only";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";

      push = {
        default = "current";
        autoSetupRemote = true;
        followTags = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
      };

      url = {
        "https://github.com/".insteadOf = "github:";
        "ssh://git@github.com/".pushInsteadOf = "github:";
        "https://gitlab.com/".insteadOf = "gitlab:";
        "ssh://git@gitlab.com/".pushInsteadOf = "gitlab:";
      };
    };
  };
}
