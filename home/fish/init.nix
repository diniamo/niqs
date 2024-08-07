{config, ...}: {
  # This does a lot of useless stuff, like theming the terminal itself
  # which is useless. Just adjust unwanted colors manually instead
  stylix.targets.fish.enable = false;

  # Use `-U` because it's slightly faster
  programs.fish.interactiveShellInit = ''
    if not set -q fish_configured
      set -U fish_greeting

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

      set -U theme_configured
      set -U fish_configured
    end
  '';

  xdg.configFile."fish/config.fish".onChange = "rm ${config.xdg.configHome}/fish/fish_variables";
}
