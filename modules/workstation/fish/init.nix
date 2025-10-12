{ lib, config, ... }: let
  inherit (lib) mkOption types;
in {
  options = {
    custom.fish = {
      initOnce = mkOption {
        type = types.lines;
        default = "set -U fish_greeting";
        description = "Commands to run on the first initialization (useful for `set -U`)";
      };
    };
  };

  config = {
    # -U is slightly faster
    custom.fish.initOnce = ''
      set -U fish_color_command green
      set -U fish_color_param white
      set -U fish_color_end blue

      set -U fish_cursor_insert line
      set -U fish_cursor_replace_once underscore
      set -U fish_cursor_replace underscore
      set -U fish_cursor_external line

      tide configure --auto \
        --style=Lean \
        --prompt_colors='16 colors' \
        --show_time='24-hour format' \
        --lean_prompt_height='Two lines' \
        --prompt_connection=Disconnected \
        --prompt_spacing=Sparse \
        --icons='Many icons' \
        --transient=Yes
      set -U tide_time_format %R
      tide reload

      set -U sponge_regex_patterns '\\/nix\\/store\\/\\S+'
    '';

    programs.fish.interactiveShellInit = ''
      if not set -q fish_configured
        ${config.custom.fish.initOnce}
        set -U fish_configured
      end
    '';
  };
}
