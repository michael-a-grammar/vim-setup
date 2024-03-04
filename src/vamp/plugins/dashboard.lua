return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  opts = {
    theme = 'doom',
    disable_move = true,

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
          key = '<space>',
          key_hl = '@character',
          key_format = ' %s',
          keymap = '<space>',
          action = "lua vim.api.nvim_input('<space><space>')",
        },

        {
          icon = '',
          icon_hl = '@attribute',
          desc = ' Git status',
          desc_hl = '@attribute',
          key = 'g',
          key_hl = '@character',
          key_format = ' %s',
          keymap = '<space> g g',
          action = "lua vim.api.nvim_input('<space>ggg')",
        },

        {
          icon = '',
          icon_hl = '@lsp.type.builtinType',
          desc = ' Recent files',
          desc_hl = '@lsp.type.builtinType',
          key = 'r',
          key_hl = '@character',
          key_format = ' %s',
          keymap = '<space> f',
          action = "lua vim.api.nvim_input('<space>fr')",
        },

        {
          icon = '',
          icon_hl = '@lsp.typemod.string.injected',
          desc = ' Recent files',
          desc_hl = '@lsp.typemod.string.injected',
          key = 't',
          key_hl = '@character',
          key_format = ' %s',
          keymap = '<space> f',
          action = "lua vim.api.nvim_input('<space>fr')",
        },

        {
          icon = '󰒲',
          icon_hl = '@constructor',
          desc = ' Lazy',
          desc_hl = '@constructor',
          key = 'p',
          key_hl = '@character',
          key_format = ' %s',
          keymap = '<space> z',
          action = "lua vim.api.nvim_command('Lazy')",
        },

        {
          icon = '󱠡',
          icon_hl = '@exception',
          desc = ' Quit',
          desc_hl = '@exception',
          key = 'q',
          key_hl = '@character',
          key_format = ' %s',
          keymap = '<space> q',
          action = "lua vim.api.nvim_input('<space>qq')",
        },
      },
    },
  },
}
