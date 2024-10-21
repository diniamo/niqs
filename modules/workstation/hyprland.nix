{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.hyprland.nixosModules.default];

  # Needed for XDPH
  environment.systemPackages = with pkgs; [grim slurp];

  programs.hyprland.enable = true;
  xdg.portal.config.common = {
    "org.freedesktop.impl.portal.Screencast" = "hyprland";
    "org.freedesktop.impl.portal.Screenshot" = "hyprland";
    "org.freedesktop.impl.portal.Screenshot.PickColor" = lib.getExe pkgs.hyprpicker;
  };
}
