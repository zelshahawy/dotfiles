# Base packages for all systems and users
{ pkgs }:

with pkgs; let
  myPython = python313.withPackages (ps: [
    ps.distutils
    ps.flit
    ps.ipython
    ps.mypy
    ps.numpy
    ps.pandas
    ps.pip
    ps.pylsp-mypy
    ps.python-lsp-server
    ps.setuptools
    ps.virtualenv
    ps.ruff
    ps.matplotlib
  ]);
in
[
  # Core terminal and development tools
  curl
  git
  jq
  wget
  fastfetch
  dos2unix
  ncdu

  # Build tools
  autoconf
  cmake
  pkgconf
  tree-sitter
  redis
  pnpm

  # Common libraries
  openssl
  readline
  ncurses

  # Python
  myPython

  # Core development
  nodejs
  rustup
]
