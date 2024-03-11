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
          icon_hl = '@error',
          desc = ' Find files',
          desc_hl = '@error',
          keymap = '<space>',
          key = '<space>',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space><space>')",
        },

        {
          icon = '',
          icon_hl = '@attribute',
          desc = ' Git status',
          desc_hl = '@attribute',
          keymap = '<space> g g',
          key = 'g',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>ggg')",
        },

        {
          icon = '',
          icon_hl = '@lsp.type.builtinType',
          desc = ' Recent files',
          desc_hl = '@lsp.type.builtinType',
          keymap = '<space> f',
          key = 'r',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>fr')",
        },

        {
          icon = '',
          icon_hl = '@lsp.typemod.string.injected',
          desc = ' Recent files',
          desc_hl = '@lsp.typemod.string.injected',
          keymap = '<space> f',
          key = 't',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>fr')",
        },

        {
          icon = '󰒲',
          icon_hl = '@constructor',
          desc = ' Lazy',
          desc_hl = '@constructor',
          keymap = '<space> z',
          key = 'p',
          key_hl = '@character',
          key_format = ' %s',
          action = "lua vim.api.nvim_command('Lazy')",
        },

        {
          icon = '󱠡',
          icon_hl = '@exception',
          desc = ' Quit',
          desc_hl = '@exception',
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
