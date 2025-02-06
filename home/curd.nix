{flakePkgs, lib, ...}: let
  inherit (builtins) isList concatStringsSep;
  inherit (lib.generators) toKeyValue mkKeyValueDefault mkValueStringDefault;

  package = flakePkgs.curd.default.override { withMpv = false; };

  settings = {
    AddMissingOptions = false;

    NextEpisodePrompt = true;
    SkipRecap = false;
    SaveMpvSpeed = false;
    DiscordPresence = false;
    AlternateScreen = false;
    MpvArgs = ["--profile=anime"];
  };
in {
  home.packages = [package];
  xdg.configFile."curd/curd.conf".text = toKeyValue {
    mkKeyValue = mkKeyValueDefault {
      mkValueString = v: let
        default = mkValueStringDefault {};
      in
        if isList v then "[${concatStringsSep "," (map (e: "\"${default e}\"") v)}]"
        else default v;
    } "=";
  } settings;
}
