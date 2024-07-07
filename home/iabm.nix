{pkgs, ...}: {
  home.packages = [pkgs.iamb];

  xdg.configFile."iamb/config.toml".source = pkgs.writers.writeTOML "iamb-config.toml" {
    profiles.diniamo.user_id = "@diniamo:matrix.org";
  };
}
