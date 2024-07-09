{
  imports = [./symbols.nix];

  programs.starship = {
    enable = true;
    enableFishIntegration = false;

    settings = {
      format = "$directory$time$all";

      nix_shell.unknown_msg = "shell";
      time = {
        disabled = false;
        time_format = "%R";
        style = "bold purple";
      };
    };
  };
}
