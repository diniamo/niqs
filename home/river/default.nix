{
  config,
  pkgs,
  flakePkgs,
  ...
}: let
  rgb = hex: "0x${hex}";
in {
  imports = [
    ./maps.nix
    ./spawn.nix
  ];

  home.packages = with pkgs; [
    wayshot
    slurp
    gammastep
    flakePkgs.bgar.default
  ];

  wayland.windowManager.river = {
    enable = true;

    settings = with config.lib.stylix.colors; {
      # TODO: What does this do?
      # default-attach-mode

      background-color = rgb base00;
      border-color-focused = rgb base0D;
      border-color-unfocused = rgb base03;
      border-color-urgent = rgb base08;
      border-width = 1;
      xcursor-theme = "${config.stylix.cursor.name} ${toString config.stylix.cursor.size}";

      focus-follows-cursor = "normal";
      hide-cursor.when-typing = true;
      # TODO: on-focus-change or on-output-change?
      # set-cursor-warp

      rule-add = "ssd";
      default-layout = "rivertile";
      spawn = ["rivertile"];

      keyboard-layout = "-options caps:swapescape,altwin:swap_lalt_lwin hu";
      # input."*" = {
      #   accel-profile = "flat";
      #   pointer-accel = 0;
      #   # disable-while-typing = true;
      #   middle-emulation = true; # Is this for scrolling?
      # };
    };
  };
}
