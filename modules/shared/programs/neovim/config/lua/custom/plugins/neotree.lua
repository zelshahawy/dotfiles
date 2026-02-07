return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	cmd = { "Neotree" },
	keys = {
		{ "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Toggle neotree" },
		{ "<C-e>", "<cmd>Neotree focus<cr>", desc = "Focus neotree" },
		{ "\\", "<cmd>Neotree reveal<cr>", desc = "Reveal neotree" },
	},
	opts = {
		close_if_last_window = true,
		window = { width = 30 },
	},

	-- If you use lazy.nvim, `init` runs early (before the plugin loads).
	-- That’s a good place to set global diagnostic config once.
	init = function()
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = "󰌵",
				},
				-- If you prefer number-column highlights or line highlights, you can add:
				-- numhl = {
				--   [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
				--   [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
				--   [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
				--   [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
				-- },
			},
			-- other diagnostic prefs you like:
			-- virtual_text = false,
			-- underline = true,
			-- update_in_insert = false,
		})

		-- (Optional) keep your custom colors for the sign highlight groups:
		-- vim.api.nvim_set_hl(0, 'DiagnosticSignError', { fg = '#f38ba8' })
		-- vim.api.nvim_set_hl(0, 'DiagnosticSignWarn',  { fg = '#f9e2af' })
		-- vim.api.nvim_set_hl(0, 'DiagnosticSignInfo',  { fg = '#89b4fa' })
		-- vim.api.nvim_set_hl(0, 'DiagnosticSignHint',  { fg = '#94e2d5' })
	end,

	config = function(_, opts)
		-- ✅ Just set up neo-tree as usual:
		require("neo-tree").setup(opts)
	end,
}
