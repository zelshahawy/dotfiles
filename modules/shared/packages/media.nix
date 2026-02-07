# Media and graphics packages
{ pkgs }:

with pkgs;
[
  # Graphics and media libraries
  cairo
  adwaita-icon-theme
  gtk3
  gtksourceview
  libxml2

  # Build dependencies for media apps
  expat
  gettext
  gnupatch
  parallel
  rlwrap
  ccache
  libgit2
  zstd
]
