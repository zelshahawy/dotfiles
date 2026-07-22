# Development packages that can be enabled per system
{ pkgs }:

with pkgs;
[
  # Advanced development tools
  # android-tools
  # google-cloud-sdk
  # code-cursor
  discord

  # Language servers and tools
  ccls
  languagetool
  nil
  basedpyright
  texlab # latex
  typst
  tinymist # typst
  millet # SML
  nixpkgs-fmt # for nix
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
