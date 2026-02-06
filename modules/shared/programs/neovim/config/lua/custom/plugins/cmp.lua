return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			keys = {
				{
					"<C-k>",
					function()
						local ls = require("luasnip")
						if ls.expand_or_jumpable() then
							ls.expand_or_jump()
						end
					end,
					desc = "Expand lua snippet or jump next",
					mode = { "i", "s" },
				},
				{
					"<C-j>",
					function()
						local ls = require("luasnip")
						if ls.jumpable(-1) then
							ls.jump(-1)
						end
					end,
					desc = "Lua snippet jump previous",
					mode = { "i", "s" },
				},
				{
					"<C-l>",
					function()
						local ls = require("luasnip")
						if ls.choice_active() then
							ls.change_choice(1)
						end
					end,
					desc = "Lua snippet change choice",
					mode = "i",
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",

		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",

		--[[ -- Vimtex uses omni completions
    'hrsh7th/cmp-omni' ]]
	},
}
