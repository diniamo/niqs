{
  custom.fzf = {
    enable = true;

    colors = {
      bg = "-1";
      "bg+" = "-1";
      fg = "-1";
      "fg+" = "-1:bold";
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
      "--pointer=>"
      "--bind=ctrl-s:toggle"
    ];
  };
}
