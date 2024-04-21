{
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.modules.style;

  inherit (cfg.colorScheme) colors;
in {
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    settings = {
      main = {
        term = "xterm-256color";

        selection-target = "clipboard";

        font = "${cfg.monoFont.name}:size=${cfg.monoFont.sizeString}";
        dpi-aware = true;
        pad = "10x10 center";
      };
      scrollback.lines = 10000;
      tweak.font-monospace-warn = "no";
      cursor.style = "beam";
      mouse.hide-when-typing = "yes";

      colors = {
        foreground = colors.base05; # Text
        background = colors.base00; # Base

        regular0 = colors.base03; # Surface 1
        regular1 = colors.base08; # red
        regular2 = colors.base0B; # green
        regular3 = colors.base0A; # yellow
        regular4 = colors.base0D; # blue
        regular5 = colors.base0F; # pink
        regular6 = colors.base0C; # teal
        regular7 = colors.base06; # Subtext 0
        # Subtext 1 ???
        bright0 = colors.base04; # Surface 2
        bright1 = colors.base08; # red
        bright2 = colors.base0B; # green
        bright3 = colors.base0A; # yellow
        bright4 = colors.base0D; # blue
        bright5 = colors.base0F; # pink
        bright6 = colors.base0C; # teal
        bright7 = colors.base07; # Subtext 0
      };
    };
  };

  # This lets foot keep track the CWD
  programs.zsh.initExtra = ''
    osc7-pwd() {
      emulate -L zsh # also sets localoptions for us
      setopt extendedglob
      local LC_ALL=C
      printf '\e]7;file://%s%s\e\' $HOST ''${PWD//(#m)([^@-Za-z&-;_~])/%''${(l:2::0:)$(([##16]#MATCH))}}
    }
    chpwd-osc7-pwd() {
      (( ZSH_SUBSHELL )) || osc7-pwd
    }
    add-zsh-hook -Uz chpwd chpwd-osc7-pwd
  '';
}
