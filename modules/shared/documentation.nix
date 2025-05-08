{
  documentation = {
    # I always just use my browser
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;

    man = {
      enable = true;
      # Same here
      generateCaches = false;
    };
  };
}
