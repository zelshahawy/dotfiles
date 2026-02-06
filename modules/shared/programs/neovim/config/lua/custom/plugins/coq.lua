return {
	ft = "coq",
	"whonore/Coqtail",
	dependencies = {
		{
			"tomtomjhj/coq-lsp.nvim",
			opts = {
				lsp = {
					on_attach = require("custom.util.lspconfig").on_attach,
					init_options = {
						show_notices_as_diagnostics = true,
					},
					-- autostart = false,
				},
			},
		},
	},
}
