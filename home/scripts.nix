{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (pkgs) writeShellScript;
in {
  options = {
    scripts = mkOption {
      description = "Scripts used throughout my home config";
      type = types.attrs;
    };
  };

  config = {
    scripts = {
      openImage = writeShellScript "open-image" ''
        case "$(wl-paste --list-types)" in
          *text*)
            notify-send 'Opening image URL'
            curl -sL "$(wl-paste)" | swayimg -
            ;;
          *image*)
            notify-send 'Opening image'
            wl-paste | swayimg -
            ;;
          *)
            notify-send 'Clipboard content is not an image'
            ;;
        esac
      '';
    };
  };
}
