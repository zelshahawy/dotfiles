# Neovim plugin versions

Tree-sitter and Tree-sitter textobjects use `main` and require Neovim 0.12.
`config/lazy-lock.json` records exact plugin commits and is shared by Home Manager.
After pulling the dotfiles and rebuilding, run `:Lazy restore` and then `:TSUpdate`.
Restart Neovim once parser installation completes.

Home Manager deploys a read-only lockfile. At startup the configuration copies it
into Neovim's writable state directory because Lazy writes even during restore.
Normal `:Lazy update` changes are therefore temporary until recorded in the
repository lockfile. To intentionally update shared pins, launch:

```sh
NVIM_LAZY_LOCKFILE="$HOME/.config/nix/modules/shared/programs/neovim/config/lazy-lock.json" nvim
```

Run `:Lazy update`, review and commit the lockfile changes, then rebuild on both
machines. When adding the lockfile for the first time, stage it with Git before
building a Git-backed Nix flake so Nix includes it. If Home Manager reports that
an existing `~/.config/nvim/lazy-lock.json` blocks activation, move that file to a
backup location and rebuild.

The listed parsers are installed with the documented `install` API. Highlighting
and indentation are enabled by a FileType callback for the configured languages;
LaTeX keeps VimTeX highlighting. After first installation, reopen the buffer.
For another language, add its parser to the install list and its filetype to the
autocommand patterns. MDX, folds, and textobject shortcuts are retained.
Ctrl-Space and Alt-Space use Neovim's native expand/shrink selection. Ctrl-S now
selects the local scope through the textobjects plugin; it no longer maintains
legacy incremental scope-selection history.
