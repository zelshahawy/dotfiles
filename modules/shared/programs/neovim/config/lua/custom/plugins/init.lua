return {
	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", opts = {} },

			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {}, event = "LspAttach" },

			-- Additional lua configuration, makes nvim stuff amazing!
			{ "folke/neodev.nvim", opts = {} },

			-- As you type parameter listing
			{ "ray-x/lsp_signature.nvim", opts = { floating_window = false }, event = "VeryLazy" },
		},
	},

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {}, event = "VeryLazy" },

	-- <Ctrl-DIRECTION> and better tmux integration
	"christoomey/vim-tmux-navigator",

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = "|",
				section_separators = "",
				globalstatus = true,
			},
		},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	{
		-- Lean proofing helper
		"Julian/lean.nvim",
		ft = "lean",
		opts = {
			lsp = {
				on_attach = require("custom.util.lspconfig").on_attach,
			},
			mappings = true,
			infoview = {
				width = 50,
			},
		},
	},

	{
		-- Auto pair text objects
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		-- Easier mainpulation (add/remove/change) of pairs
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	-- Latex
	{
		"lervag/vimtex",
		-- not ft='latex' because the plugin itself offers the ft
		event = "VeryLazy",
		init = function()
			vim.g.conceal_level = 2
			vim.g.vimtex_view_method = "skim"
		end,
	},

	-- Better vim.fn.input and vim.fn.select
	{ "stevearc/dressing.nvim", event = "VeryLazy" },

	{
		-- Better undoing experience
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
		},
	},

	-- Icons in nvim tabs
	{ "alvarosevilla95/luatab.nvim", opts = {} },

	-- gth
	{ "github/copilot.vim", enabled = false },

	-- Highlight todo
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			search = {
				pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},
}
