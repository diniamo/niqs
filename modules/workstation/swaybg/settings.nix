{ config, ... }: {
  custom.swaybg = {
    enable = true;

    image = config.custom.style.wallpaper;
    mode = "fill";
  };
}
