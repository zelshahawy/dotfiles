return {
	"mrcjkb/rustaceanvim",
	version = "^8", -- Recommended
	ft = { "rust" },
	config = function()
		vim.g.rustaceanvim = {
			server = {
				on_attach = require("custom.util.lspconfig").on_attach,
			},
		}
	end,
}
