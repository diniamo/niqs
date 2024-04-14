{
  pkgs,
  config,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider =
      if config.programs.gamemode.enable
      then
        pkgs.ananicy-cpp-rules.overrideAttrs {
          configurePhase = ''
            runHook preConfigure
            rm -r 00-default/games
            runHook postConfigure
          '';
        }
      else pkgs.ananicy-cpp-rules;
  };
}
