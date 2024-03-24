{
  programs.git = {
    enable = true;

    userName = "diniamo";
    userEmail = "diniamo69@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
