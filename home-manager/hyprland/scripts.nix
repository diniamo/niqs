{pkgs}: let
  inherit (pkgs) writeShellScript;
in {
  pin = writeShellScript "pin.sh" ''
    if ! hyprctl -j activewindow | jq -e .floating; then
        hyprctl dispatch togglefloating
    fi
    hyprctl dispatch pin
  '';
}
