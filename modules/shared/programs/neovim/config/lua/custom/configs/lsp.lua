-- [[ Configure LSP ]]

local on_attach = require("custom.util.lspconfig").on_attach

local servers = {
	-- C/C++ LSP
	clangd = {},

	-- Go LSP
	gopls = {},

	-- TypeScript/JavaScript LSP

	-- Ansible LSP

	-- Python LSP with additional plugins
	basedpyright = {
		settings = {
			basedpyright = {
				analysis = {
					inlayHints = {
						callArgumentNames = false,
					},
				},
			},
		},
	},

	ruff = {}, -- For formatting

	-- Lua LSP
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
				completion = {
					callSnippet = "Replace",
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},

	-- Haskell
	hls = {},
	-- Nix LSP
	nil_ls = {
		settings = {
			["nil"] = {
				formatting = {
					command = { "nixpkgs-fmt" },
				},
				nix = {
					flake = {
						autoArchive = true,
					},
				},
			},
		},
	},

	ts_ls = {}, -- for typescript

	-- Rust LSP already configured

	-- Markdown
	markdown_oxide = {},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function merge(a, b)
	return vim.tbl_deep_extend("force", a or {}, b or {})
end

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Set up each server
for name, opts in pairs(servers) do
	local base = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	vim.lsp.config(name, merge(base, opts))
end

vim.lsp.enable(vim.tbl_keys(servers))
-- vim: ts=2 sts=2 sw=2 et
