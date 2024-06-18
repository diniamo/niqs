{config, ...}: {
  users.users.${config.values.mainUser} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  fonts.fontconfig.subpixel.rgba = "rgb";
}
