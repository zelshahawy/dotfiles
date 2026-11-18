-- [[ Zeal: offline docs for C/C++ ]]
-- `gK` on a symbol (or a visual selection) opens it in Zeal's C++ docset.
-- `K` still shows clangd's hover.

local zeal = vim.fn.exepath("zeal")

-- Docset keyword per filetype (see DocSetPlatformFamily in the docset's Info.plist)
local docsets = {
	c = "c",
	cpp = "cpp",
}

local function open_in_zeal(query)
	if zeal == "" then
		vim.notify("zeal not found in PATH", vim.log.levels.ERROR)
		return
	end
	if query == nil or query == "" then
		return
	end
	local keyword = docsets[vim.bo.filetype]
	local arg = keyword and (keyword .. ":" .. query) or query
	-- Zeal is single-instance: if already running, the query goes to that window.
	vim.fn.jobstart({ zeal, arg }, { detach = true })
end

local function visual_selection()
	local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
	return vim.trim(table.concat(lines, " "))
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("CustomZeal", { clear = true }),
	pattern = vim.tbl_keys(docsets),
	callback = function(ev)
		vim.keymap.set("n", "gK", function()
			open_in_zeal(vim.fn.expand("<cword>"))
		end, { buffer = ev.buf, desc = "Open symbol in Zeal" })

		vim.keymap.set("x", "gK", function()
			open_in_zeal(visual_selection())
		end, { buffer = ev.buf, desc = "Open selection in Zeal" })
	end,
})
