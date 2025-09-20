return {
  {
    'kaarmu/typst.vim',
    -- not ft='typst' because the plugin itself offers the ft
    event = 'VeryLazy',
    init = function()
      vim.g.typst_syntax_highlight = 0
      vim.g.typst_conceal_emoji = true
    end
  },
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '0.3.*',
    build = function() require 'typst-preview'.update() end,
  }
}
