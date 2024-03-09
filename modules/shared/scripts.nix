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

    if [ "$1" = "full" ]; then
      flake="$(${getSystemFlake} "$2")"
      flake_root="$(cut -d"#" -f1 <<< "$flake")"
      cd "$flake_root"

      # Adds every every untracked file to the index
      ${getExe pkgs.git} add -AN

      ${getExe pkgs.deadnix} -eq ./**/*.nix
      ${getExe pkgs.statix} fix
      ${getExe pkgs.alejandra} -q .

      shift
    else
      flake="$(${getSystemFlake} "$1")"
    fi

    [ -n "$1" ] && shift
    nixos-rebuild --use-remote-sudo switch --flake "$flake" "$@"
  '';
in {
  environment.systemPackages = [
    rebuild
  ];
}
