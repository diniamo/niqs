# Credit: https://github.com/fufexan/nix-gaming/blob/master/modules/pipewireLowLatency.nix
# MIT license
{ config, pkgs, lib, ... }: let
  inherit (lib) mkIf;
  inherit (lib.generators) toLua;
  
  quantum = 64;
  rate = 48000;
  qr = "${toString quantum}/${toString rate}";
in mkIf config.custom.gaming.enable {
  services.pipewire = {
    extraConfig.pipewire = {
      "99-lowlatency" = {
        context = {
          properties.default.clock.min-quantum = quantum;
          modules = [
            {
              name = "libpipewire-module-rtkit";
              flags = [ "ifexists" "nofail" ];
              args = {
                nice.level = -15;
                rt = {
                  prio = 88;
                  time.soft = 200000;
                  time.hard = 200000;
                };
              };
            }
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                server.address = [ "unix:native" ];
                pulse.min = {
                  req = qr;
                  quantum = qr;
                  frag = qr;
                };
              };
            }
          ];

          stream.properties = {
            node.latency = qr;
            resample.quality = 1;
          };
        };
      };
    };

    wireplumber = {
      configPackages = let
        matches = toLua {
          multiline = false;
          indent = false;
        } [[[ "node.name" "matches" "alsa_output.*" ]]];

        apply_properties = toLua {} {
          "audio.format" = "S32LE";
          "audio.rate" = rate * 2;
          "api.alsa.period-size" = 2;
        };
      in [
        (pkgs.writeTextDir "share/lowlatency.lua.d/99-alsa-lowlatency.lua" ''
          alsa_monitor.rules = {
            {
              matches = ${matches};
              apply_properties = ${apply_properties};
            }
          }
        '')
      ];
    };
  };
}
