{pkgs, ...}: let
  vendor = pkgs.runCommandLocal "fish-vendor" {} ''
    mkdir -p $out/share/fish
    ln -s ${./functions} $out/share/fish/vendor_functions.d
    ln -s ${./completions} $out/share/fish/vendor_completions.d
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

  user.packages = with pkgs.fishPlugins; [
    vendor

    tide
    autopair
    spone
  ];
}
