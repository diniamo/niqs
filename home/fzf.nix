{config, ...}: {
  stylix.targets.fzf.enable = false;

  programs.fzf = {
    enable = true;
    enableZshIntegration = false;

    colors."bg+" = config.lib.stylix.colors.withHashtag.base00;
    defaultOptions = ["--border=rounded"];
  };
}
