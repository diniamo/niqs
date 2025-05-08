{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "diniamo";
        email = "diniamo53@gmail.com";
      };

      ui = {
        diff.tool = ["difft" "--color=always" "$left" "$right"];
        merge-editor = ["emacs" "--eval" "(ediff-merge-files-with-ancestor \"$left\" \"$right\" \"$base\" nil \"$output\")"];
      };

      git = {
        fetch = ["upstream" "origin"];
        push = "origin";
      };
    };
  };
}
