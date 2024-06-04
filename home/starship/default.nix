{flakePkgs, ...}: {
  imports = [./symbols.nix];

  programs.starship = {
    enable = true;
    package = flakePkgs.niqspkgs.starship-nix3-shell;

    settings = {
      nix_shell.unknown_msg = "shell";
    };
  };
}
