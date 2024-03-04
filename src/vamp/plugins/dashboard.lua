return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  opts = {
    theme = 'doom',

    config = {
      week_header = {
        enable = true,
      },

      center = {
        {
          icon = ' ',
          icon_hl = 'Title',
          desc = 'Find files',
          desc_hl = 'String',
          key = 'f',
          keymap = 'SPC SPC',
          key_hl = 'Number',
          key_format = ' %s', -- remove default surrounding `[]`
          action = 'lua print(2)',
        },

        {
          icon = ' ',
          desc = 'Recent files',
          key = 'r',
          keymap = 'SPC f d',
          key_format = ' %s', -- remove default surrounding `[]`
          action = 'lua print(3)',
        },
      },
    },
  },
}
