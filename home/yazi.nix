{
  programs.yazi = {
    enable = true;
    settings = {
      opener = {
        reveal = [
          {
            run = "exiftool \"$1\" | $PAGER";
            block = true;
            desc = "Show EXIF";
            for = "unix";
          }
        ];
        play = [
          {
            run = "mpv \"$@\"";
            orphan = true;
            for = "unix";
          }
          {
            run = "mediainfo \"$1\" | $PAGER";
            block = true;
            desc = "Show media info";
            for = "unix";
          }
        ];
      };
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on = [
            "w"
          ];
          run = "shell \"$SHELL\" --block --confirm";
          desc = "Open a shell";
        }
        {
          on = [
            "W"
          ];
          run = "tasks_show";
          desc = "Show the task manager";
        }
        {
          on = [
            "X"
          ];
          run = [
            "unyank"
            "escape --select --visual"
          ];
          desc = "Same as Y";
        }
        {
          on = [
            "d"
          ];
          run = [
            "remove --force"
            "escape --select --visual"
          ];
          desc = "Move to trash";
        }
        {
          on = [
            "e"
          ];
          run = "shell gtrash restore --cwd .";
          desc = "Restore files from the trash";
        }
        {
          on = [
            "<Enter>"
          ];
          run = "plugin --sync smart-enter";
          desc = "Enter directory or open file";
        }
      ];
      input.prepend_keymap = [
        {
          on = ["<Esc>"];
          run = "close";
          desc = "Cancel input";
        }
      ];
      tasks.prepend_keymap = [
        {
          on = ["W"];
          run = "close";
          desc = "Hide the task manager";
        }
      ];
    };
  };
}
