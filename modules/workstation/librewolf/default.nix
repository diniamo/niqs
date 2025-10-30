{ pkgs, lib, lib', config, ... }: let
  inherit (lib') attrsToLines;
  inherit (builtins) mapAttrs toJSON isBool isInt isString;

  prefs = import ./prefs.nix config;

  extensions = import ./extensions.nix;
  extensionsPrivate = import ./extensions-private.nix;

  extraPolicies = {
    SearchEngines = {
      Add = [{
        Name = "Kagi";
        Description = "Privacy focused ad-free search engine";
        IconURL = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAy0lEQVR4AWMAgf+bJScA8X+S8BbJmRDNmyRnggTIxBMYiFF4d47kf0lJyf8qCphyOA3Y3QrSBMMkGqAgi64ZJAaWI2zA88UwTTAxBP/+PCIM0FeHaUbgX+shYgYaRBhgog1RfGUaQuzqNIiYuS4RBvzdhHDyjmbJ/2trYXwiw2BKNkgxJm6KJ8oAVNs6kiX/N8TB5Eg04Ptayf8/1kHwz/VkGICJCRqAwKk+kv9tDSX/J3pK/i8KlfzvbIrbEKJzoqs5yFvUzZETQHoBtSJpXxn0lvEAAAAASUVORK5CYII=";
        Method = "GET";
        URLTemplate = "https://kagi.com/search?q={searchTerms}";
        SuggestURLTemplate = "https://kagi.com/api/autosuggest?q={searchTerms}";
      }];
      Default = "Kagi";
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

  extraMakeWrapperArgs = [
    # For libva
    "--set" "MOZ_DISABLE_RDD_SANDBOX" "1"
  ];

  prefValue = pref: toJSON (
    if isBool pref || isInt pref || isString pref
    then pref
    else toString pref
  );
  extraPrefs = attrsToLines (name: value: "lockPref(\"${name}\", ${prefValue value});") prefs;

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
      inherit extraPolicies extraPrefs;
    }).overrideAttrs (prev: {
      makeWrapperArgs = prev.makeWrapperArgs ++ extraMakeWrapperArgs;
    });

    user.packages = [ cfg.finalPackage ];
  };
}
