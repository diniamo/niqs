{config, ...}: {
  users.users.${config.values.mainUser} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  fonts.fontconfig.subpixel.rgba = "rgb";

  # This is already enabled by modules that require it
  # but I felt like enabling it anyway
  hardware.graphics.enable = true;
}
