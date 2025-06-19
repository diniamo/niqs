{ pkgs, config, lib, ... }: let
  inherit (lib) getExe';
  inherit (pkgs) coreutils;

  ln = getExe' coreutils "ln";

  vendor = pkgs.runCommandLocal "fish-vendor" {} ''
    ${getExe' coreutils "mkdir"} -p $out/share/fish
    ${ln} -s ${./functions} $out/share/fish/vendor_functions.d
    ${ln} -s ${./completions} $out/share/fish/vendor_completions.d
  '';
in {
  imports = [
    ./init.nix
    ./aliases.nix
    ./abbreviations.nix
  ];
  
  programs.fish = {
    enable = true;
    useBabelfish = true;
  };

  user = {
    shell = config.programs.fish.package;
    
    packages = with pkgs.fishPlugins; [
      vendor

      tide
      autopair
      sponge
    ];
  };
}
