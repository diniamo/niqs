{ inputs, pkgs, lib, flakePkgs, config, ... }: let
  inherit (lib) mkOption makeSearchPath makeBinPath replaceString escapeShellArgs getExe;
  inherit (lib.types) package;
  inherit (pkgs.writers) writeDash;

  packages = import ./packages.nix { inherit (flakePkgs.niqspkgs) tree-sitter-odin; };
  
  extraPath = with pkgs; [
    perl # For magit
    hunspell
    
    flakePkgs.niqspkgs.my-cookies # For leetcode
  ];
  
  hunspellDicts = with pkgs.hunspellDicts; [ en-us hu-hu ];

  overrides = final: prev: {
    odin-ts-mode = final.melpaBuild {
      pname = "odin-ts-mode";
      version = inputs.odin-ts-mode.lastModifiedDate;
      src = inputs.odin-ts-mode.outPath;
    };
    
    org-autolist = prev.org-autolist.overrideAttrs {
      patches = [ ./org-autolist-new-paragraph.patch ];
    };
  };

  emacs = pkgs.emacs.override {
    withNativeCompilation = true;
    withJansson = true;
    withPgtk = true;
    withMailutils = false;
  };

  makeWrapperArgs = [
    "--set" "DICPATH" (makeSearchPath "share/hunspell" hunspellDicts)
    "--prefix" "PATH" ":" (makeBinPath extraPath)
  ];
  
  cfg = config.custom.emacs;
in {
  options = {
    custom.emacs.finalPackage = mkOption {
      type = package;
      readOnly = true;
      description = "The wrapped Emacs package.";
    };
  };

  config = {
    custom.emacs.finalPackage = ((emacs.pkgs.overrideScope overrides).withPackages packages).overrideAttrs (prev: {
      # There is no better way to override this
      # Avoids double wrapping
      buildCommand = replaceString
        "wrapProgramBinary $out/bin/$progname"
        "wrapProgramBinary $out/bin/$progname ${escapeShellArgs makeWrapperArgs}"
        prev.buildCommand;
    });
    
    user.packages = [ cfg.finalPackage ];
    environment.sessionVariables.EDITOR = writeDash "emacs-nw.sh" "${getExe cfg.finalPackage} -nw \"$@\"";
  };
}
