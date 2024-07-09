{inputs, ...}: {
  imports = [inputs.nix-index-database.hmModules.nix-index];

  programs = {
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
  };

  # Not using the included wrapper, since the DB is symlinked to the appropriate place anyway,
  # and it's not possible to pass a custom comma package to it
  home.packages = [pkgs.comma];
}
