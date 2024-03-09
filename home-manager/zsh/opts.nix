{lib}: let
  set = [
    "AUTO_CD"
    "CORRECT"
    "HIST_REDUCE_BLANKS"
  ];
  unset = [
    "HIST_BEEP"
  ];
in ''
  setopt ${lib.concatStringsSep " " set}
  unsetopt ${lib.concatStringsSep " " unset}
''
