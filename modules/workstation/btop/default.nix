{lib, lib', pkgs, config, ...}: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf mapAttrs' nameValuePair optionalAttrs optionalString;
  inherit (lib.types) attrsOf oneOf str bool int package;
  inherit (lib') toBtopConf toBtopTheme attrsToLines;
  inherit (pkgs.writers) writeText;

  cfg = config.custom.btop;

  settingsFile = writeText "btop.conf" (toBtopConf cfg.settings);

  wrapped = pkgs.symlinkJoin {
    inherit (cfg.package) version meta;
    pname = "btop-wrapped";

    paths = [ cfg.package ];

    nativeBuildInputs = pkgs.makeBinaryWrapper;
    postBuild = optionalString (cfg.settings != {}) ''
      wrapProgram $out/bin/btop \
        --add-flags '--config ${settingsFile}'
    '' + optionalString (cfg.themes != {}) (attrsToLines (theme: colors: ''
      cat <<EOF > $out/share/btop/themes/${theme}.theme
      ${toBtopTheme colors}
      EOF
    '') cfg.themes);
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.btop = {
      enable = mkEnableOption "btop";
      
      package = mkPackageOption pkgs "btop" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped btop package.";
      };

      settings = mkOption {
        type = attrsOf (oneOf [ str bool int ]);
        default = {};
        description = "Configuration written to `.config/btop/btop.conf`.";
      };

      themes = mkOption {
        type = attrsOf (attrsOf str);
        default = {};
        description = "Themes written to the `.config/btop/themes` directory. The `theme[]` part must be ommitted from each key.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.btop.finalPackage =
      if cfg.settings != {} || cfg.themes != {} then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
