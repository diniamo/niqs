{config, ...}: let
  inherit (config.lib.stylix) colors;

  rgb = hex: "0x${hex}";
in {
  wayland.windowManager.river.settings = {
    # TODO: What does this do?
    # default-attach-mode

    background-color = rgb colors.base00;
    border-color-focused = rgb colors.base0D;
    border-color-unfocused = rgb colors.base03;
    border-color-urgent = rgb colors.base08;
    border-width = 1;
    xcursor-theme = "${config.stylix.cursor.name} ${toString config.stylix.cursor.size}";

    focus-follows-cursor = "normal";
    hide-cursor.when-typing = true;
    # TODO: on-focus-change or on-output-change?
    # set-cursor-warp

    rule-add = ["ssd"];
    default-layout = "rivertile";
    spawn = ["'rivertile -view-padding 0 -outer-padding 0'"];

    keyboard-layout = "-options caps:swapescape,altwin:swap_lalt_lwin hu";
    input."*" = {
      accel-profile = "flat";
      disable-while-typing = true;

      # How do I get middle mouse scroll?
      # scroll-method = "button";
      # scroll-button = "BTN_MIDDLE";
      # middle-emulation = "enabled";
    };
  };
}
