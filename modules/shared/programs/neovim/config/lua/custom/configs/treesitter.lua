vim.filetype.add({ extension = { mdx = "mdx" } })
vim.treesitter.language.register("markdown", "mdx")

require("nvim-treesitter").install({
	"c", "cpp", "go", "lua", "python", "tsx", "javascript", "typescript",
	"vimdoc", "vim", "rust", "markdown", "markdown_inline",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("CustomTreesitter", { clear = true }),
	pattern = {
		"c", "cpp", "go", "lua", "python", "typescriptreact", "javascript",
		"javascriptreact", "typescript", "help", "vim", "rust", "markdown", "mdx",
	},
	callback = function()
		-- Parsers install asynchronously; reopen the buffer after first installation.
		if pcall(vim.treesitter.start) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

require("nvim-treesitter-textobjects").setup({
	select = { lookahead = true },
	move = { set_jumps = true },
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

-- Textobject selection.
vim.keymap.set({ "x", "o" }, "aa", function()
	select.select_textobject("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
	select.select_textobject("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "af", function()
	select.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
	select.select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
	select.select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
	select.select_textobject("@class.inner", "textobjects")
end)

-- Jump between functions and classes.
vim.keymap.set({ "n", "x", "o" }, "]m", function()
	move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]]", function()
	move.goto_next_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]M", function()
	move.goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "][", function()
	move.goto_next_end("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[m", function()
	move.goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[[", function()
	move.goto_previous_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[M", function()
	move.goto_previous_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[]", function()
	move.goto_previous_end("@class.outer", "textobjects")
end)

vim.keymap.set("n", "<leader>a", function()
	swap.swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>A", function()
	swap.swap_previous("@parameter.inner")
end)

-- Native node selection and local scope selection.
vim.keymap.set({ "n", "x" }, "<c-space>", function()
	vim.treesitter.select("parent")
end)
vim.keymap.set("x", "<M-space>", function()
	vim.treesitter.select("child")
end)
vim.keymap.set("x", "<c-s>", function()
	select.select_textobject("@local.scope", "locals")
end)
