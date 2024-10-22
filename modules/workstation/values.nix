{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options = {
    values = {
      mainUser = mkOption {
        description = "The name of the main user";
        type = types.str;
        default = "diniamo";
      };

      terminal = {
        command = mkOption {
          description = "The terminal command to run";
          type = types.str;
          default = "foot";
        };
        separator = mkOption {
          description = "The separator between the terminal command and the command it should run";
          type = types.str;
          default = "--";
        };
        firstInstance = mkOption {
          description = "The command for the first instance of the terminal";
          type = types.nullOr types.str;
          default = null;
        };
      };
    };
  };
}
