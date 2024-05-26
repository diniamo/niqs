{
  imports = [./symbols.nix];

  programs.starship = {
    enable = true;
    settings = {
      nix_shell.unknown_msg = "shell";
    };
  };
}
