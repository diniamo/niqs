{ lib, pkgs, config, ... }: let
  inherit (lib) getExe;
in {
  custom.jujutsu = {
    enable = true;

    settings = {
      user = {
        name = "diniamo";
        email = "diniamo53@gmail.com";
      };

      aliases = {
        tug = [ "bookmark" "move" "--from" "closest_bookmark(@-)" "--to" "@-" ];
        init = [ "git" "init" ];
        push = [ "git" "push" ];
        pull = [ "git" "fetch" ];
        lift = [ "squash" "--from" "@-" "--to" "@" ];
        raise = [ "new" "--insert-before" "@" "--no-edit" ];
        mark = [ "bookmark" "create" "--revision" "@-" ];
      };

      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
      };

      templates.draft_commit_description = ''
        concat(
          coalesce(description, "\n"),
          surround(
            "\nJJ: This commit contains the following changes:\n", "",
            indent("JJ:     ", diff.stat(72))
          ),
          "\nJJ: ignore-rest\n",
          diff.git()
        )
      '';

      revsets = {
        log = "..";
      };

      ui = {
        default-command = "status";
        diff-editor = ":builtin";
        diff-formatter = [ (getExe pkgs.difftastic) "--color=always" "$left" "$right" ];
        merge-editor = [ (getExe pkgs.meld) "$left" "$base" "$right" "-o" "$output" ];
      };

      git = {
        fetch = [ "upstream" "origin" ];
        push = "origin";
        push-new-bookmarks = true;
        colocate = false;
        executable-path = getExe config.custom.git.package;
      };
    };
  };
}
