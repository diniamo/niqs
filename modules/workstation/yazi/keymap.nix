{
  programs.yazi.settings.keymap = {
    mgr.prepend_keymap = [
      { on = [ "g" "c" ]; run = "cd /etc/nixos"; desc = "Go to system configuration"; }
      { on = [ "g" "t" ]; run = "cd /tmp"; desc = "Go to temporary directory"; }
      { on = [ "g" "s" ]; run = "cd /tmp/downloads"; desc = "Go to downloads"; }
      { on = [ "g" "d" ]; run = "cd ~/documents"; desc = "Go to documents"; }
      { on = [ "g" "p" ]; run = "cd ~/documents/dev"; desc = "Go to development directory"; }
      { on = [ "g" "e" ]; run = "arrow bot"; desc = "Go to bottom"; }
      { on = "s"; run = "filter --smart"; desc = "Filter files"; }
      { on = "S"; run = "search --via=fd"; desc = "Search files by name via fd"; }
      { on = "<C-s>"; run = "search --via=rg"; desc = "Search files by content via ripgrep"; }
      { on = "%"; run = "toggle_all --state=on"; }
      { on = "z"; run = "plugin zoxide"; }
      { on = "Z"; run = "plugin fzf"; }

      { on = "O"; run = "noop"; }
      { on = "G"; run = "noop"; }

      { on = "e"; run = "shell --block -- gtrash restore"; desc = "Restore trashed files"; }
      { on = "o"; run = "shell -- dragon-drop --and-exit --all \"$@\""; desc = "Drop files to GUI"; }

      { on = [ "c" "p" ]; run = "plugin chmod"; desc = "Chmod selected files"; }
      { on = "f"; run = "plugin jump-to-char"; desc = "Jump to files that start with the character typed after f"; }
      { on = "M"; run = "plugin mount"; desc = "Mount manager"; }
      { on = "<Enter>"; run = "plugin smart-enter"; desc = "Enter the directory, or open the file"; }
      { on = "p"; run = "plugin smart-paste"; desc = "Paste into hovered or current directory"; }
      { on = "<C-y>"; run = "plugin wl-clipboard"; desc = "Copy to system clipboard"; }
      { on = "<C-t>"; run = "plugin toggle-pane min-preview"; desc = "Hide preview"; }
      { on = "<C-p>"; run = "plugin toggle-pane max-preview"; desc = "Maximize preview"; }
      { on = "<C-l>"; run = "plugin toggle-pane max-current"; desc = "Maximize current direcotry"; }
      { on = "<C-i>"; run = "plugin toggle-pane min-parent"; desc = "Hide parent"; }
    ];

    input.prepend_keymap = [
      { on = "<Esc>"; run = "close"; desc = "Cancel input"; }
    ];

    help.prepend_keymap = [
      { on = "f"; run = "noop"; }
      { on = "/"; run = "filter"; }
      { on = "q"; run = "close"; }
    ];
  };
}
