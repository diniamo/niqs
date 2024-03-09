{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) writeShellScript writeShellScriptBin;
  inherit (lib) getExe;

  getSystemFlake = writeShellScript "get-flake-path" ''
    stored_flake_path="''${XDG_STATE_HOME:-$HOME/.local/state}/rebuild_flake"

    if [ -z "$1" ]; then
      if [ -f "$stored_flake_path" ]; then
        flake="$(cat "$stored_flake_path")"
      else
        printf "Flake path: " 1>&2
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
      case "$arg" in
        full)
          full=true
          ;;
        -*)
          extra_args+=("$arg")
          ;;
        *)
          flake="$(${getSystemFlake} "$arg")"
          ;;
      esac
    done
    [[ -z "$flake" ]] && flake="$(${getSystemFlake})"

    if ''${full:-false}; then
      flake_root="$(cut -d"#" -f1 <<< "$flake")"
      cd "$flake_root"

      # Adds every every untracked file to the index
      ${getExe pkgs.git} add -AN

      ${getExe pkgs.deadnix} -eq ./**/*.nix
      ${getExe pkgs.statix} fix
      ${getExe pkgs.alejandra} -q .
    fi

    nixos-rebuild --use-remote-sudo switch --flake "$flake" "''${extra_args[@]}"
  '';
in {
  environment.systemPackages = [
    rebuild
  ];
}
