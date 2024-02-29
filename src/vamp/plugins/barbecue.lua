return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',

  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },

  opts = {
    show_basename = false,
    theme = 'catppuccin',

    symbols = {
      separator = '',
    },
  },

  config = function(_, opts)
    local set_keymap = vim.keymap.set

    require('barbecue').setup(opts)

    set_keymap({ 'n', 'x' }, '<leader>kb', function()
      require('barbecue.ui').toggle()
    end, { desc = 'Toggle barbecue', noremap = true })
  end,
}
