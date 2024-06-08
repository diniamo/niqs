{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.hyprland.nixosModules.default];

  programs.hyprland.enable = true;
  # TODO: does the module system have a built-in way to prepend to a list?
  xdg.portal.config.common.default = lib.mkForce ["hyprland" "kde"];
}
