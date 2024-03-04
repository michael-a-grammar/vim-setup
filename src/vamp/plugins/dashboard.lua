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
  -- stylua: ignore start
      header = {
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
      },
      -- stylua: ignore end

      center = {
        {
          icon = '',
          icon_hl = '@error',
          desc = ' Find files',
          desc_hl = '@error',
          key = 'f',
          key_hl = '@character',
          keymap = 'SPC SPC',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space><space>')",
        },

        {
          icon = '',
          icon_hl = '@attribute',
          desc = ' Git status',
          desc_hl = '@attribute',
          key = 'g',
          key_hl = '@character',
          keymap = 'SPC g g',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>gg')",
        },

        {
          icon = '',
          icon_hl = '@lsp.type.builtinType',
          desc = ' Recent files',
          desc_hl = '@lsp.type.builtinType',
          key = 'r',
          key_hl = '@character',
          keymap = 'SPC f r',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>fr')",
        },

        {
          icon = '',
          icon_hl = '@lsp.typemod.string.injected',
          desc = ' Recent files',
          desc_hl = '@lsp.typemod.string.injected',
          key = 't',
          key_hl = '@character',
          keymap = 'SPC f t',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>fr')",
        },

        {
          icon = '󰒲',
          icon_hl = '@constructor',
          desc = ' Lazy',
          desc_hl = '@constructor',
          key = 'p',
          key_hl = '@character',
          keymap = 'SPC z p',
          key_format = ' %s',
          action = "lua vim.api.nvim_command('Lazy')",
        },

        {
          icon = '󱠡',
          icon_hl = '@exception',
          desc = ' Quit',
          desc_hl = '@exception',
          key = 'q',
          key_hl = '@character',
          keymap = 'SPC q q',
          key_format = ' %s',
          action = "lua vim.api.nvim_input('<space>qq')",
        },
      },
    },
  },
}
