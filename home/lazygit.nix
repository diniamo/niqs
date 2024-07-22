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
          description = "Delete both local and remote branch";
          key = "D";
          context = "localBranches";
          prompts = [
            {
              type = "confirm";
              title = "Delete both local and remote branch";
              body = "Are you are you want to delete this branch both locally and remotely?";
            }
          ];
          loadingText = "Deleting branch";
          command = "git push {{ .SelectedLocalBranch.UpstreamRemote }} --delete {{ .SelectedLocalBranch.UpstreamBranch }}; git branch --delete --force {{ .SelectedLocalBranch.Name }}";
        }
        {
          description = "Push branch to origin";
          key = "<c-p>";
          context = "localBranches";
          loadingText = "Pushing to origin";
          command = "git push --set-upstream origin";
        }
      ];
    };
  };
}
