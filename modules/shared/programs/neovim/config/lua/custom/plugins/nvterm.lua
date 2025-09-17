return {
  'NvChad/nvterm',
  opts = {},

  keys = {
    {
      '<A-m>',
      function()
        require('nvterm.terminal').toggle 'float'
      end,
      desc = 'Toggle floating term',
      mode = { 'n', 't' },
    },
    {
      '<A-">',
      function()
        require('nvterm.terminal').toggle 'horizontal'
      end,
      desc = 'Toggle horizontal term',
      mode = { 'n', 't' },
    },
    {
      '<A-v>',
      function()
        require('nvterm.terminal').toggle 'vertical'
      end,
      desc = 'Toggle vertical term',
      mode = { 'n', 't' },
    },
  },
}
