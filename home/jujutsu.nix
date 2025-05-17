{
  programs.jujutsu = {
    enable = true;
    settings = {
      aliases = {
        tug = ["bookmark" "move" "--from" "closest_bookmark(@-)" "--to" "@-"];
        push = ["git" "push"];
        lift = ["squash" "--from" "@-" "--to" "@"];
        raise = ["new" "--insert-before" "@" "--no-edit"];
      };

      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
      };

      user = {
        name = "diniamo";
        email = "diniamo53@gmail.com";
      };

      ui = {
        default-command = "status";
        diff-editor = ":builtin";
        diff.tool = ["difft" "--color=always" "$left" "$right"];
        merge-editor = ["emacs" "--eval" "(ediff-merge-files-with-ancestor \"$left\" \"$right\" \"$base\" nil \"$output\")"];
      };

      git = {
        fetch = ["upstream" "origin"];
        push = "origin";
        push-new-bookmarks = true;
      };
    };
  };
}
