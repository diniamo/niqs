{
  pkgs,
  getExe,
}: let
  inherit (pkgs) writeShellScript;
in {
  pin = writeShellScript "pin.sh" ''
    if ! hyprctl -j activewindow | ${getExe pkgs.jq} -e .floating; then
        hyprctl dispatch togglefloating
    fi
    hyprctl dispatch pin
  '';
}
