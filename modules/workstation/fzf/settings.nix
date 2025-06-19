{
  custom.fzf = {
    enable = true;

    colors = {
      bg = "black";
      "bg+" = "black";
      fg = "white";
      "fg+" = "bright-white";
      hl = "green";
      "hl+" = "green";
      info = "yellow";
      marker = "cyan";
      prompt = "blue";
      spinner = "magenta";
      pointer = "blue";
      header = "red:bold";
    };
        
    flags = [
      "--border=rounded"
      "--pointer='>'"
      "--bind=ctrl-s:toggle"
    ];
  };
}
