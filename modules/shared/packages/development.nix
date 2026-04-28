# Development packages that can be enabled per system
{ pkgs }:

with pkgs;
[
  # Advanced development tools
  # android-tools
  # google-cloud-sdk
  postman
  # code-cursor
  discord

  # Language servers and tools
  bash-language-server
  ccls
  languagetool
  nil
  basedpyright
  gopls
  lua-language-server
  taplo # toml
  texlab # latex
  typst
  tinymist # typst
  millet # SML
  nixpkgs-fmt # for nix
  typescript-language-server # for typescript, tx
  just-lsp

  # repl

  # Specialized tools
  # elan
  # fstar
  lua5_4
  ollama
  opam
  just

  # qemu
  z3
]
