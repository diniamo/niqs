{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) writeShellScriptBin;
  inherit (pkgs.writers) writeDash writeDashBin;
  inherit (lib) getExe;

  getSystemFlake = writeDash "get-flake-path" ''
    stored_flake_path="''${XDG_STATE_HOME:-$HOME/.local/state}/rebuild_flake"

    if [ -z "$1" ]; then
      if [ -f "$stored_flake_path" ]; then
        flake="$(cat "$stored_flake_path")"
      else
        printf "Flake path (/path/to/flake/root#hostname): " 1>&2
        read -r flake
        printf "%s" "$flake" > "$stored_flake_path"
      fi
    else
      flake="$1"
      printf "%s" "$flake" > "$stored_flake_path"
    fi

    printf "%s" "$flake"
  '';

  rebuild = writeShellScriptBin "rebuild" ''
    set -e

    declare -a extra_args
    for arg in "$@"; do
      if [[ -d "''${arg%#*}" ]]; then
        flake="$(${getSystemFlake} "$arg")"
      else
        case "$arg" in
          -f|--full)
            full=true
            ;;
          -d|--debug)
            extra_args+=("--show-trace" "--no-eval-cache")
            ;;
          *)
            extra_args+=("$arg")
            ;;
        esac
      fi
    done
    [[ -z "$flake" ]] && flake="$(${getSystemFlake})"

    flake_root="''${flake%#*}"
    flake_hostname="''${flake##*#}"

    if ''${full:-false}; then
      cd "$flake_root"

      # Adds every every untracked file to the index
      ${getExe pkgs.git} add -AN

      ${getExe pkgs.deadnix} .
      ${getExe pkgs.statix} check
      ${getExe pkgs.alejandra} -q .
    fi

    if [[ -n "$flake_hostname" ]]; then
      ${getExe pkgs.nh} os switch --hostname "$flake_hostname" "$flake_root" -- "''${extra_args[@]}"
    else
      ${getExe pkgs.nh} os switch "$flake_root" -- "''${extra_args[@]}"
    fi
  '';

  osrepl = writeDashBin "osrepl" ''
    nixos-rebuild --flake "$(${getSystemFlake})" repl
  '';
in {
  environment.systemPackages = [
    rebuild
    osrepl
  ];
}
