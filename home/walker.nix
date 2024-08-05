{
  inputs,
  flakePkgs,
  ...
}: {
  imports = [inputs.walker.homeManagerModules.default];

  programs.walker = {
    enable = true;
    package = flakePkgs.walker.default;
    runAsService = true;

    # config = { };
  };
}
