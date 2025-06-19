{ pkgs, lib, lib', config, ... }: let
  inherit (lib') attrsToLines;
  inherit (builtins) mapAttrs toJSON isBool isInt isString;
  
  prefs = import ./prefs.nix;

  extensions = import ./extensions.nix;
  extensionsPrivate = import ./extensions-private.nix;

  searchEngines = import ./search-engines.nix;
  
  policies = {
    SearchEngines = {
      Add = searchEngines;
      Default = "SearXNG";
    };
    ExtensionSettings = mapAttrs (_: storeId: {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${storeId}/latest.xpi";
      installation_mode = "force_installed";
    }) extensions // mapAttrs (_: storeId: {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/${storeId}/latest.xpi";
      installation_mode = "force_installed";
      private_browsing = true;
    }) extensionsPrivate;
  };
  # This is needed since the LibreWolf policies would always override the ones passed to extraPolicies (see nixpkgs Firefox wrapper)
  policiesFiles = [ (pkgs.writeText "policy-overrides.json" (toJSON {inherit policies;})) ];

  extraMakeWrapperArgs = [
    # For libva
    "--set" "MOZ_DISABLE_RDD_SANDBOX" "1"
  ];

  prefValue = pref: toJSON (
    if isBool pref || isInt pref || isString pref
    then pref
    else toString pref
  );
  jsPrefs = attrsToLines (name: value: "lockPref(\"${name}\", ${prefValue value});") prefs;

  package = pkgs.librewolf;

  cfg = config.custom.librewolf;
in {
  options = {
    custom.librewolf.finalPackage = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      description = "The wrapped LibreWolf package.";
    };
  };

  config = {
    custom.librewolf.finalPackage = (package.override {
      extraPoliciesFiles = package.unwrapped.extraPoliciesFiles ++ policiesFiles;
      extraPrefs = jsPrefs;
    }).overrideAttrs (prev: {
      makeWrapperArgs = prev.makeWrapperArgs ++ extraMakeWrapperArgs;
    });
    
    user.packages = [ cfg.finalPackage ];
  };
}
