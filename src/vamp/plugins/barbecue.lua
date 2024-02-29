return {
  'utilyre/barbecue.nvim',
  name = 'barbecue',
  version = '*',

  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },

  config = {
    show_basename = false,
    theme = 'catppuccin',

    symbols = {
      separator = '',
    },
  },
}
