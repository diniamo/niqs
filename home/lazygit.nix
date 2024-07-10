{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        language = "en";
        # I can't find where these are used, but I should change them once I do
        # timeFormat = "";
        # shortTimeFormat = "";
        nerdFontsVersion = 3;
        filterMode = "fuzzy";
      };
      update.method = "never";
      promptToReturnFromSubprocess = false;

      customCommands = [
        {
          key = "D";
          context = "localBranches";
          stream = true;
          prompts = [
            {
              type = "confirm";
              title = "Delete branch locally and remotely";
              body = "Are you are you want to delete this branch both locally and remotely?";
            }
          ];
          command = "git push {{ .SelectedLocalBranch.UpstreamRemote }} --delete {{ .SelectedLocalBranch.UpstreamBranch }}; git branch --delete {{ .SelectedLocalBranch.Name }}";
        }
      ];
    };
  };
}
