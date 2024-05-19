{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types getExe;

  crudini = getExe pkgs.crudini;
  toIniBool = bool:
    if bool
    then "True"
    else "False";

  path = "/var/lib/satisfactory";
  cfg = config.services.satisfactory;
in {
  options = {
    services.satisfactory = {
      enable = mkEnableOption "Satisfactory dedicated server";

      maxPlayers = mkOption {
        description = "Player limit";
        type = types.int;
        default = 3;
      };
      autoPause = mkOption {
        description = "Automatically pause the game when there are no palyers online";
        type = types.bool;
        default = true;
      };
      autoSaveOnDisconnet = mkOption {
        description = "Automatically save the game when a player disconnects";
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    # Needed since Satisfactory stores save files in home
    users.users.satisfactory = {
      home = path;
      group = "satisfactory";
      createHome = true;
      isSystemUser = true;
    };
    users.groups.satisfactory = {};

    networking.firewall.allowedUDPPorts = [15777 15000 7777];

    systemd.services.satisfactory = {
      description = "Satisfactory dedicated server";

      preStart = ''
        ${getExe pkgs.steamcmd} \
          +force_install_dir ${path}/SatisfactoryDedicatedServer \
          +login anonymous \
          +app_update 1690800 \
          validate \
          +quit
        ${getExe pkgs.patchelf} --set-interpreter ${pkgs.glibc}/lib/ld-linux-x86-64.so.2 ${path}/SatisfactoryDedicatedServer/Engine/Binaries/Linux/UnrealServer-Linux-Shipping

        mkdir -p ${path}/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer
        ${crudini} --set ${path}/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/Game.ini '/Script/Engine.GameSession' MaxPlayers ${toString cfg.maxPlayers}
        ${crudini} \
          --set ${path}/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/ServerSettings.ini '/Script/FactoryGame.FGServerSubsystem' mAutoPause ${toIniBool cfg.autoPause} \
          --set ${path}/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/ServerSettings.ini '/Script/FactoryGame.FGServerSubsystem' mAutoSaveOnDisconnect ${toIniBool cfg.autoSaveOnDisconnet}
      '';
      serviceConfig = {
        ExecStart = "${path}/SatisfactoryDedicatedServer/Engine/Binaries/Linux/UnrealServer-Linux-Shipping FactoryGame -DisablePacketRouting";
        # steamcmd can be slow, especially on the initial download
        # shutdown is also either slow or indefinite
        TimeoutSec = "infinity";
        User = "satisfactory";
        Group = "satisfactory";
        WorkingDirectory = path;
      };
      environment.LD_LIBRARY_PATH = "SatisfactoryDedicatedServer/linux64:SatisfactoryDedicatedServer/Engine/Binaries/Linux";
    };
  };
}
