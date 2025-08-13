-- [[ Configure LSP ]]

local on_attach = require('custom.util.lspconfig').on_attach

local servers = {
  -- C/C++ LSP
  clangd = {},

  -- Go LSP
  gopls = {},

  -- TypeScript/JavaScript LSP

  -- Ansible LSP

  -- Python LSP with additional plugins
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = 'basic',
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
        formatting = {
          provider = 'yapf',
        },
        linting = {
          enabled = true,
          pylintEnabled = false,
          flake8Enabled = false,
          mypyEnabled = true,
          ruffEnabled = true,
        },
      },
    },
  },

  -- Nix LSP
  nil_ls = {
    settings = {
      ['nil'] = {
        formatting = {
          command = { 'nixpkgs-fmt' }
        },
        nix = {
          flake = {
            autoArchive = true
          }
        }
      }
    }
  },

  -- Rust LSP
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Set up each server
for server, opts in pairs(servers) do
  local base_config = {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers[server],
    filetypes = (servers[server] or {}).filetypes,
  }

  for opt, value in pairs(opts) do
    base_config[opt] = value
  end
  require('lspconfig')[server].setup(base_config)
end

-- vim: ts=2 sts=2 sw=2 et
