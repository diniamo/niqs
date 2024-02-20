{ config, inputs, ... }: {
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      stable.flake = inputs.stable;
    };

    nixPath = [
      "nixpkgs=/etc/nix/inputs/nixpkgs"
      "stable=/etc/nix/inputs/stable"
    ];
  };
  environment.etc = {
    "nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
    "nix/inputs/stable".source = inputs.stable.outPath;
  };

  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "hu";
  };

  users.users.${config.modules.values.mainUser} = {
   isNormalUser = true;
   extraGroups = [ "wheel" ];
  };
}

