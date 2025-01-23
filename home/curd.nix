{flakePkgs, lib, ...}: let
  package = flakePkgs.curd.default.override { withMpv = false; };

  settings = {
    NextEpisodePrompt = true;
    SkipRecap = false;
    SaveMpvSpeed = false;
    DiscordPresence = false;
  };
in {
  home.packages = [package];
  xdg.configFile."curd/curd.conf".text = lib.generators.toKeyValue {} settings;
}
