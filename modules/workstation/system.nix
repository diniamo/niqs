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
        pkgs.ananicy-rules-cachyos.overrideAttrs {
          preInstall = ''
            rm -r 00-default/games
          '';
        }
      else pkgs.ananicy-cpp-rules;
  };
}
