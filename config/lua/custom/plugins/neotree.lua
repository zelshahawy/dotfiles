return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = { 'Neotree' },
  keys = {
    { '<C-n>', '<cmd> Neotree toggle <cr>', desc = 'Toggle neotree' },
    { '<C-e>', '<cmd> Neotree focus <cr>',  desc = 'Focus neotree' },
    { '\\',    '<cmd> Neotree reveal <cr>', desc = 'Reveal neotree' }
  },

  opts = {
    close_if_last_window = true,
    window = {
      width = 30
    }
  },

  config = function(_, opts)
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define('DiagnosticSignError',
      { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn',
      { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo',
      { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint',
      { text = '󰌵', texthl = 'DiagnosticSignHint' })

    require('neo-tree').setup(opts)
  end

}
