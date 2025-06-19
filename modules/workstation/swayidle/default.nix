{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf getExe concatMap optionals escapeShellArgs;
  inherit (lib.types) listOf submodule int str nullOr enum;

  cfg = config.custom.swayidle;

  timeoutFlags = concatMap (timeout:
    [ "timeout" (toString timeout.time) timeout.command ]
    ++ optionals (timeout.resume != null) [ "resume" timeout.resume ]
  ) cfg.timeouts;
  eventFlags = concatMap (event: [ event.type event.command ]) cfg.events;
  idleHintFlag = [ "idlehint" cfg.idleHint ];

  flags = cfg.extraFlags ++ timeoutFlags ++ eventFlags ++ idleHintFlag;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.swayidle = {
      enable = mkEnableOption "swayidle";
      package = mkPackageOption pkgs "swayidle" {};

      extraFlags = mkOption {
        type = listOf str;
        default = [];
        description = "Extra flags to pass.";
      };

      timeouts = mkOption {
        type = listOf (submodule {
          options = {
            time = mkOption {
              type = int;
              description = "Timeout in seconds.";
            };

            command = mkOption {
              type = str;
              description = "Command to run on timeout.";
            };

            resume = mkOption {
              type = nullOr str;
              default = null;
              description = "Command to run on resume.";
            };
          };
        });
        default = [];
        description = "Timeouts to define.";
      };
      events = mkOption {
        type = listOf (submodule {
          options = {
            type = mkOption {
              type = enum [ "before-sleep" "after-resume" "lock" "unlock" ];
              description = "Event to run on.";
            };

            command = mkOption {
              type = str;
              description = "Command to run on event.";
            };
          };
        });
        default = [];
      };
      idleHint = mkOption {
        type = nullOr int;
        default = null;
        description = "Set the (e)logind IdleHint after this many seconds.";
      };
    };
  };

  config = mkIf cfg.enable {
    user.packages = [ cfg.package ];
    
    systemd.user.services.swayidle = {
      description = "Swayidle idle manager.";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      path = [ pkgs.dash ];
      serviceConfig.ExecStart = "${getExe cfg.package} ${escapeShellArgs flags}";
    };
  };
}
