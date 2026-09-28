-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: I need to set mapleader and maplocalleader before
-- loading lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.tabstop = 2 -- Set tab width to 2 spaces
vim.opt.shiftwidth = 2 -- Indentation uses 2 spaces
vim.opt.softtabstop = 2 -- Tabs behave like 2 spaces
vim.opt.expandtab = true -- Convert tabs to spacesxw
vim.cmd("set nowrap") -- No Wrapping
vim.opt.termguicolors = true

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
-- Home Manager's shared lockfile is read-only. Lazy also writes during restore,
-- so use a writable copy, refreshed from the shared pins at each startup.
-- Set NVIM_LAZY_LOCKFILE to the repository lockfile when intentionally updating.
local lockfile = vim.env.NVIM_LAZY_LOCKFILE
if not lockfile or lockfile == "" then
	local shared_lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"
	lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json"
	vim.fn.mkdir(vim.fn.stdpath("state"), "p")
	if vim.fn.filereadable(shared_lockfile) == 1 then
		vim.fn.writefile(vim.fn.readfile(shared_lockfile), lockfile)
	end
end

require("lazy").setup("custom.plugins", {
	lockfile = lockfile,
	defaults = {
		cond = true,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

require("custom.configs")

local opts = { noremap = true, silent = true }
vim.cmd([[ au VimLeave * set guicursor=a:ver20 ]])
--NOTE
vim.api.nvim_set_keymap(
	"n",
	"<C-f>",
	"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
	{ noremap = true, silent = false }
)
vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

-- vim: ts=2 sts=2 sw=2 et
--
