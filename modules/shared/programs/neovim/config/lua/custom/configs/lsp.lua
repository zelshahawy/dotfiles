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
  ruff = {},

  basedpyright = {
    settings = {
      analysis = {
        inlayHints = {
          callArgumentNames = false,
        }
      }
    }
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
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function merge(a, b) return vim.tbl_deep_extend('force', a or {}, b or {}) end

capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
