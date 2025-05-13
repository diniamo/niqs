{
  programs.less = {
    enable = true;

    envVariables.LESS = "--quit-if-one-screen --use-color --RAW-CONTROL-CHARS";
    commands = {
      "^P" = "back-line";
      "^N" = "forw-line";
      "^F" = "right-scroll";
      "^B" = "left-scroll";

      "^A" = "goto-line";
      "^E" = "goto-end";
    };
  };
}
