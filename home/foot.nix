{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        selection-target = "clipboard";

        # dpi-aware = true;
        pad = "10x10 center";
      };
      scrollback.lines = 10000;
      tweak.font-monospace-warn = "no";
      cursor.style = "beam";
      mouse.hide-when-typing = "yes";
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
