{
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    settings.PermitRootLogin = "yes";
  };
}
