{
  flakePkgs,
  config,
  pkgs,
  ...
}: let
  inherit (config.stylix) cursor;
in {
  stylix.cursor = {
    package = pkgs.bibata-cursors.overrideAttrs {
      buildPhase = ''
        runHook preBuild
        ctgen build.toml -s ${toString cursor.size} -p x11 -d "$bitmaps/${cursor.name}" -n '${cursor.name}' -c '${cursor.name} variant'
        runHook postBuild
      '';
    };
    name = "Bibata-Modern-Classic";
    size = 22;
  };

  environment.systemPackages = [flakePkgs.niqspkgs.bibata-hyprcursor];
  environment.variables = {
    HYPRCURSOR_THEME = "Bibata-modern";
    HYPRCURSOR_SIZE = cursor.size;
  };
}
