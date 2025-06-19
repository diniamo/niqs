{ inputs, pkgs, lib, flakePkgs, config, ... }: let
  inherit (lib) makeSearchPath makeBinPath replaceString escapeShellArgs;
  inherit (pkgs.writers) writeDash;

  packages = import ./packages { inherit (flakePkgs.niqspkgs) tree-sitter-odin; };
  
  extraPath = with pkgs; [
    perl # For magit
    hunspell
    
    flakePkgs.niqspkgs.my-cookies # For leetcode
  ];
  
  hunspellDicts = with pkgs.hunspellDicts; [en-us hu-hu];

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

  emacs = pkgs.emacs30.override {
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
    custom.emacs.finalPackage = lib.mkOption {
      type = lib.types.package;
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
    environment.sessionVariables.EDITOR = writeDash "emacs-terminal.sh" "emacs -nw \"$@\"";
  };
}
