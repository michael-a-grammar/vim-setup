return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',

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
    require('barbecue').setup(opts)

    vim.keymap.set({ 'n', 'x' }, '<leader>kb', function()
      require('barbecue.ui').toggle()
    end, { desc = 'Toggle barbecue', noremap = true })
  end,
}
