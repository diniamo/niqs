{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (pkgs.writers) writeDash;
in {
  options = {
    scripts = mkOption {
      description = "Scripts used throughout my home config";
      type = types.attrs;
    };
  };

  config = {
    scripts = {
      openImage = writeDash "open-image" ''
        case "$(wl-paste --list-types)" in
          *image*)
            notify-send 'Opening image'
            wl-paste | swayimg -
            ;;
          *text*)
            notify-send 'Opening image URL'
            curl -sL "$(wl-paste)" | swayimg -
            ;;
          *)
            notify-send 'Clipboard content is not an image'
            ;;
        esac
      '';
    };
  };
}
