{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.modules.values = {
    mainUser = mkOption {
      description = "The name of the main user";
      type = types.str;
    };
    terminal = mkOption {
      description = "The terminal command to run";
      type = types.str;
    };
    nvidia = mkOption {
      description = "Whether the current machine is running Nvidia (this should not be set explicitly)";
      type = types.bool;
    };
  };

  config.modules.values = {
    mainUser = "diniamo";
    terminal = "foot";
  };
}
