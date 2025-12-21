{ lib, config, ... }: let
  inherit (lib) getExe;
in {
  programs.less = {
    enable = true;

    envVariables.LESS = "--ignore-case --incsearch --use-color --RAW-CONTROL-CHARS";

    clearDefaultCommands = true;
    commands = {
      "j" = "forw-line";
      "^N" = "forw-line";
      "\\r" = "forw-line";
      "\\n" = "forw-line";
      "\\kd" = "forw-line";
      "J" = "forw-line-force";

      "k" = "back-line";
      "^P" = "back-line";
      "\\ku" = "back-line";
      "K" = "back-line-force";

      "^D" = "forw-scroll";
      "^U" = "back-scroll";

      "^F" = "forw-screen";
      "\\kD" = "forw-screen";
      "^B" = "back-screen";
      "\\kU" = "back-screen";

      "f" = "forw-forever";
      "F" = "forw-until-hilite";

      "r" = "repaint";
      "^R" = "repaint";
      "^L" = "repaint";
      "R" = "repaint-flush";

      "g" = "goto-line";
      "\\kh" = "goto-line";
      "p" = "percent";
      "%" = "percent";

      "G" = "goto-end";
      "\\ke" = "goto-end";

      "h" = "left-scroll";
      "\\kl" = "left-scroll";
      "H" = "no-scroll";

      "l" = "right-scroll";
      "\\kr" = "right-scroll";
      "L" = "end-scroll";

      "{" = "forw-bracket {}";
      "}" = "back-bracket {}";
      "(" = "forw-bracket ()";
      ")" = "back-bracket ()";
      "[" = "forw-bracket []";
      "]" = "back-bracket []";

      "^G" = "status";

      "&" = "filter";
      "/" = "forw-search";
      "?" = "back-search";
      "n" = "repeat-search";
      "N" = "reverse-search";

      "^O^N" = "osc8-forw-search";
      "^O^P" = "osc8-back-search";
      "^O^O" = "osc8-open";

      "m" = "set-mark";
      "M" = "set-mark-bottom";
      "'" = "goto-mark";

      "-" = "toggle-option";
      ">" = "toggle-option o";
      "_" = "display-option";

      ":e" = "examine";
      ":q" = "quit";
      "q" = "quit";
      "\\e" = "quit";

      "|" = "pipe";
      "!" = "shell";
      "#" = "pshell";
      "v" = "visual";

      "0" = "digit";
      "1" = "digit";
      "2" = "digit";
      "3" = "digit";
      "4" = "digit";
      "5" = "digit";
      "6" = "digit";
      "7" = "digit";
      "8" = "digit";
      "9" = "digit";

      "^H" = "help";
      "^V" = "version";
    };
  };

  environment.sessionVariables.PAGER = getExe config.programs.less.package;
}
