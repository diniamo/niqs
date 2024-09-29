{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.hyprland.nixosModules.default];

  programs.hyprland.enable = true;
  xdg.portal.config.common.default = lib.mkForce ["hyprland" "gtk"];
}
