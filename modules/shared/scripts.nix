{pkgs, ...}: let
  inherit (pkgs) writeShellScriptBin;

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

    ${pkgs.git}/bin/git add .

    ${pkgs.deadnix}/bin/deadnix -eq ./**/*.nix
    ${pkgs.statix}/bin/statix fix
    ${pkgs.alejandra}/bin/alejandra -q .

    sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake "$flake"
  '';
in {
  environment.systemPackages = [
    pkgs.coreutils-full

    rebuild
  ];
}
