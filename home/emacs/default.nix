{inputs, pkgs, ...}: let
  tree-sitter-odin = pkgs.tree-sitter.buildGrammar {
    language = "tree-sitter-odin";
    version = "0-unstable-${inputs.tree-sitter-odin.shortRev}";
    src = inputs.tree-sitter-odin.outPath;
    meta.homepage = "https://github.com/amaanq/tree-sitter-odin";
  };

  overrides = final: _: {
    odin-ts-mode = final.melpaBuild {
      pname = "odin-ts-mode";
      version = inputs.odin-ts-mode.lastModifiedDate;
      src = inputs.odin-ts-mode.outPath;
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
    direnv
    avy
    editorconfig
    no-littering

    ripgrep
    projectile

    (treesit-grammars.with-grammars (grammars: with grammars; [
      # tree-sitter-elisp
      tree-sitter-nix
      tree-sitter-odin
      tree-sitter-julia
      tree-sitter-nu
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
