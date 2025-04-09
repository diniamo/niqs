{inputs, pkgs, lib, flakePkgs, ...}: let
  packages = epkgs: with epkgs; [
    catppuccin-theme
    doom-modeline
    avy
    editorconfig
    no-littering
    magit
    dumb-jump
    expand-region
    move-text
    multiple-cursors
    olivetti
    envrc
    surround
    leetcode
    ripgrep
    company
    flycheck
    yasnippet

    org-autolist
    org-roam
    org-roam-timestamps
    org-roam-ui

    (treesit-grammars.with-grammars (grammars: with grammars; [
      tree-sitter-nix
      tree-sitter-odin
      tree-sitter-julia
      tree-sitter-nu
      tree-sitter-c
      tree-sitter-rust
      tree-sitter-go
      tree-sitter-gomod
    ]))
    nix-ts-mode
    odin-ts-mode
    julia-ts-mode
    nushell-ts-mode
  ];
  
  extraPath = with pkgs; [
    perl # For magit
    hunspell
    
    flakePkgs.niqspkgs.my-cookies # For leetcode
  ];
  
  hunspellDicts = with pkgs.hunspellDicts; [en-us hu-hu];

  tree-sitter-odin = pkgs.tree-sitter.buildGrammar {
    language = "tree-sitter-odin";
    version = "0-unstable-${inputs.tree-sitter-odin.shortRev}";
    src = inputs.tree-sitter-odin.outPath;
    meta.homepage = "https://github.com/amaanq/tree-sitter-odin";
  };

  overrides = final: prev: {
    odin-ts-mode = final.melpaBuild {
      pname = "odin-ts-mode";
      version = inputs.odin-ts-mode.lastModifiedDate;
      src = inputs.odin-ts-mode.outPath;
    };

    dumb-jump = prev.dumb-jump.overrideAttrs {
      patches = [(pkgs.fetchpatch2 {
        url = "https://patch-diff.githubusercontent.com/raw/jacktasia/dumb-jump/pull/460.patch";
        hash = "sha256-GoulXU4TA/kNUAlBAwie9WmrbtXplctuGHCiHMyrgN4=";
      })];
    };

    org-autolist = prev.org-autolist.overrideAttrs {
      patches = [./org-autolist-new-paragraph.patch];
    };
  };

  emacs = pkgs.emacs30.override {
    withNativeCompilation = true;
    withJansson = true;
    withPgtk = true;
    withMailutils = false;
  };

  makeWrapperArgs = [
    "--set" "DICPATH" (lib.makeSearchPath "share/hunspell" hunspellDicts)
    "--prefix" "PATH" ":" (lib.makeBinPath extraPath)
  ];
  
  finalPackage = ((emacs.pkgs.overrideScope overrides).withPackages packages).overrideAttrs (prev: {
    buildCommand =
      builtins.replaceStrings
        ["wrapProgramBinary $out/bin/$progname"]
        ["wrapProgramBinary $out/bin/$progname ${lib.escapeShellArgs makeWrapperArgs}"]
        prev.buildCommand;
  });
in {
  home.packages = [finalPackage];
}
