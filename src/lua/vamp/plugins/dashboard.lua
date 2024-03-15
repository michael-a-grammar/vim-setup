return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  opts = {
    disable_move = true,
    theme = 'doom',

    config = {
      header = {
        -- stylua: ignore start
'⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
'⠀⠀⠀⠀⠀⠀⢴⡾⢿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
'⠀⠀⠀⠀⣴⠗⠀⠀⠀⠹⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
'⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⢻⠻⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠠⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⠀⠠⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣧⠀⢴⠄⠀⠀⠀⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡆⠠⣴⡀⠀⠀⣿⣿⣿⣿⣶⣦⣤⡀⠀⠀⠀',
'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡄⢹⣧⠀⠀⠙⠛⠿⣿⣿⣿⠁⠀⠀⠀⠀',
'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣷⡀⢻⣧⠀⠸⠿⠀⣿⣿⣿⠀⠀⠀⠀⠀',
'┓┏        ⠀⠀⠀⠀⠹⣷⡀⢻⣇⠀⣴⣦⠈⣿⣿⠀⠀⠀⠀⠀',
'┃┃┏┓┏┳┓┏┓ ⠀⠀⠀⠀⠀⠹⣷⣠⣿⣆⢈⣁⣴⣿⣿⠀⠀⠀⠀⠀',
'┗┛┗┻┛┗┗┣┛ ⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀',
'       ┛ v0.0.1⠀⠀⠘⠿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀',
'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀',
        -- stylua: ignore end
      },

      center = {
        {
          icon = '󰭟',
          icon_hl = 'markdownH1',
          desc = ' Find files',
          desc_hl = 'markdownH1',
          keymap = '<space>',
          key = '<space>',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space><space>')",
        },

        {
          icon = '',
          icon_hl = 'markdownH2',
          desc = ' Neogit',
          desc_hl = 'markdownH2',
          keymap = '<space> g',
          key = 'g',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>gg')",
        },

        {
          icon = '',
          icon_hl = 'markdownH3',
          desc = ' Recent files',
          desc_hl = 'markdownH3',
          keymap = '<space> f',
          key = 'r',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>ff')",
        },

        {
          icon = '',
          icon_hl = 'markdownH4',
          desc = ' Recent files',
          desc_hl = 'markdownH4',
          keymap = '<space> f',
          key = 't',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>fr')",
        },

        {
          icon = '󰒲',
          icon_hl = 'markdownH5',
          desc = ' Lazy',
          desc_hl = 'markdownH5',
          keymap = '<space> z',
          key = 'p',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_command('Lazy')",
        },

        {
          icon = '󱠡',
          icon_hl = 'markdownH6',
          desc = ' Quit',
          desc_hl = 'markdownH6',
          keymap = '<space> q',
          key = 'q',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>qq')",
        },
      },
    },
  },
}
