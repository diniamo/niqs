{
  custom.helix = {
    enable = true;

    theme = ./theme.toml;
    settings = {
      editor = {
        line-number = "relative";
        middle-click-paste = false;
        shell = [ "/bin/sh" "-c" ];
        auto-completion = false;
        auto-format = false;
        color-modes = true;
        trim-final-newlines = true;
        trim-trailing-whitespace = true;
        clipboard-provider = "wayland";
        continue-comments = false;

        cursor-shape.insert = "bar";
        lsp.goto-reference-include-declaration = false;
        file-picker = {
          parents = false;
          ignore = false;
          git-global = false;
        };
      };

      keys = {
        normal = {
          "C-s" = ":write!";
          "C-q" = ":quit-all";
          "C-x" = ":write-quit-all";
          "C-g" = "save_selection";

          "C-a" = "no_op";
          "C-," = "decrement";
          "C-." = "increment";

          space.l = {
            c = ":lsp-workspace-command";
            r = ":lsp-restart";
            s = ":lsp-stop";
          };
        };

        select = {
          "C-s" = ":write!";
          "C-q" = ":quit-all";
          "C-x" = ":write-quit-all";
          "C-g" = "save_selection";
        };

        insert = {
          "C-s" = ":write!";
          "C-q" = ":quit-all";
          "C-x" = ":write-quit-all";
          "C-g" = "save_selection";

          "C-b" = "move_char_left";
          "C-n" = "move_visual_line_down";
          "C-p" = "move_visual_line_up";
          "C-f" = "move_char_right";
          "A-b" = [ "move_prev_word_start" "collapse_selection" ];
          "A-f" = [ "move_next_word_end" "move_char_right" ];
          "C-space" = "completion";
          "C-backspace" = "delete_word_backward";
        };
      };
    };

    languageSettings = {
      language-server = {
        tinymist.config.preview.browsing.args = [ "--data-plane-host=127.0.0.1:0" "--invert-colors=always" "--open" ];
      };

      language = [
        {
          name = "typst";
          soft-wrap.enable = true;
        }
      ];
    };
  };
}
