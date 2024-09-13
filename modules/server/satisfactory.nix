{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types getExe;

  patchelf = getExe pkgs.patchelf;
  interpreter = "${pkgs.glibc}/lib/ld-linux-x86-64.so.2";

  path = "/var/lib/satisfactory";
  cfg = config.services.satisfactory;
in {
  options = {
    services.satisfactory = {
      enable = lib.mkEnableOption "Satisfactory dedicated server";

      experimental = mkOption {
        description = "Whether to use the experimental branch";
        type = types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Needed since Satisfactory stores save files in home
    users.users.satisfactory = {
      home = path;
      group = "satisfactory";
      createHome = true;
      isSystemUser = true;
    };
    users.groups.satisfactory = {};

    networking.firewall = {
      allowedTCPPorts = [7777];
      allowedUDPPorts = [7777];
    };

    systemd.services.satisfactory = {
      description = "Satisfactory dedicated server";

      preStart = ''
        ${getExe pkgs.steamcmd} \
          +force_install_dir ${path}/SatisfactoryDedicatedServer \
          +login anonymous \
          +app_update 1690800 \
          ${lib.optionalString cfg.experimental "-beta experimental"} \
          validate \
          +quit

        ${patchelf} --set-interpreter ${interpreter} ${path}/SatisfactoryDedicatedServer/Engine/Binaries/Linux/FactoryServer-Linux-Shipping
        ${patchelf} --set-interpreter ${interpreter} ${path}/SatisfactoryDedicatedServer/Engine/Binaries/Linux/CrashReportClient
      '';

      serviceConfig = {
        ExecStart = "${path}/SatisfactoryDedicatedServer/Engine/Binaries/Linux/FactoryServer-Linux-Shipping FactoryGame -DisablePacketRouting";
        # 10 minutes might be too much for the download, but I want to be safe
        TimeoutSec = 600;
        User = "satisfactory";
        Group = "satisfactory";
        WorkingDirectory = path;
      };

      environment.LD_LIBRARY_PATH = "${path}/SatisfactoryDedicatedServer/linux64:${path}/SatisfactoryDedicatedServer/Engine/Binaries/Linux";
    };
  };
}
