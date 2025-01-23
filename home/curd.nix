{flakePkgs, lib, ...}: let
  package = flakePkgs.curd.default.override { withMpv = false; };

  settings = {
    AddMissingOptions = false;

    NextEpisodePrompt = true;
    SkipRecap = false;
    SaveMpvSpeed = false;
    DiscordPresence = false;
    AlternateScreen = false;
  };
in {
  home.packages = [package];
  xdg.configFile."curd/curd.conf".text = lib.generators.toKeyValue {} settings;
}
