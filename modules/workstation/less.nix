{
  programs.less = {
    enable = true;

    envVariables.LESS = "--quit-if-one-screen --use-color --RAW-CONTROL-CHARS";
    commands = {
      "^P" = "up";
      "^N" = "down";
      "^F" = "right";
      "^B" = "left";

      "\\eb" = "word-left";
      "\\eB" = "word-left"; 
      "\\ef" = "word-right";
      "\\eF" = "word-right";

      "^A" = "home";
      "^E" = "end";
    };
  };
}
