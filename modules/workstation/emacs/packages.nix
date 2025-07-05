{ tree-sitter-odin }: epkgs: with epkgs; [
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
  flycheck
  dape
  rainbow-mode
    
  yasnippet
  yasnippet-capf
  yasnippet-snippets
    
  vertico
  orderless
    
  corfu
  nerd-icons-corfu

  org-autolist
  org-roam

  (treesit-grammars.with-grammars (grammars: with grammars; [
    tree-sitter-nix
    tree-sitter-odin
    tree-sitter-julia
    tree-sitter-c
    tree-sitter-cpp
    tree-sitter-go
    tree-sitter-gomod
    tree-sitter-graphql
    tree-sitter-yaml
  ]))
  nix-ts-mode
  odin-ts-mode
  julia-ts-mode
  nushell-ts-mode
  graphql-ts-mode

  # TODO: tree-sitter version
  fish-mode
]
