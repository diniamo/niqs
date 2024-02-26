{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) writeShellScriptBin;
  inherit (lib) getExe;

  rebuild = writeShellScriptBin "rebuild" ''
    set -e

    flake_path="''${XDG_STATE_HOME:-$HOME/.local/state}/rebuild_flake"
    if [ -z "$1" ]; then
      if [ -f "$flake_path" ]; then
        flake="$(cat "$flake_path")"
      else
        printf "No flake path supplied, and non stored"
        exit 1
      fi
    else
      flake="$1"
      printf "%s" "$flake" > "$flake_path"
    fi

    flake_root="$(cut -d"#" -f1 <<< "$flake")"
    cd "$flake_root"

    # Adds every every untracked file to the index
    ${getExe pkgs.git} add -AN

    ${getExe pkgs.deadnix} -eq ./**/*.nix
    ${getExe pkgs.statix} fix
    ${getExe pkgs.alejandra} -q .

    ${getExe pkgs.nixos-rebuild} --use-remote-sudo switch --flake "$flake"
  '';
in {
  environment.systemPackages = [
    pkgs.coreutils-full

    rebuild
  ];
}
