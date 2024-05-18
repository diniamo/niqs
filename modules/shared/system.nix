{config, ...}: {
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "hu";

  users.users.${config.values.mainUser} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };
}
