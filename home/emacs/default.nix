{inputs, pkgs, ...}: let
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
  };

  emacs = pkgs.emacs30.override {
    withNativeCompilation = true;
    withJansson = true;
    withPgtk = true;
    withMailutils = false;
  };

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
    embrace
    multiple-cursors
    olivetti
    envrc
    
    org-roam
    org-roam-timestamps
    org-roam-ui

    ripgrep
    projectile

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

  finalPackage = (emacs.pkgs.overrideScope overrides).withPackages packages;
in {
  home.packages = [finalPackage];
}
