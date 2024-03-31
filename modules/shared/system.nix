{
  config,
  inputs,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    registry = {
      nixpkgs.flake = inputs.nixpkgs;
    };

    nixPath = [
      "nixpkgs=/etc/nix/inputs/nixpkgs"
    ];
  };
  environment.etc = {
    "nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  };

  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "hu";
  };

  boot.tmp.useTmpfs = true;

  users.users.${config.values.mainUser} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };
}
