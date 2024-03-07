return {
  'utilyre/barbecue.nvim',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'SmiteshP/nvim-navic',
  },

  opts = {
    theme = 'catppuccin',
    show_basename = false,

    symbols = {
      separator = '',
    },
  },

  config = function(_, opts)
    require('barbecue').setup(opts)

    vim.keymap.set({ 'n', 'x' }, '<leader>kb', function()
      require('barbecue.ui').toggle()
    end, { desc = 'Toggle barbecue', noremap = true })
  end,
}
