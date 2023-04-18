return function()
  local which_key = require'which-key'

  which_key.setup {
    layout     = { align = "left" },
    hidden     = { '<Plug>' },
    key_labels = {
      ['<space>'] = '',
      ['<Tab>']   = '',
      ['<Down>']  = '',
      ['<Left>']  = '',
      ['<Up>']    = '',
      ['<Right>'] = ''
    },

    popup_mappings = {
      scroll_down = '<m-down>',
      scroll_up   = '<m-up>',
    },

    disable = {
      filetypes = {
        'fern',
        'TelescopePrompt',
        'qf'
      }
    }
  }

  local to_register = {
    [','] = {
      [','] = 'which_key_ignore',

      s = {
        name = 'Sneak'
      },
    },

    ['.'] = {
      ['.'] = 'which_key_ignore'
    },

    ['<localleader>'] = {
      p = {
        name = 'Manipulate pipes'
      },

      s = {
        name = 'Find (cwd)'
      },

      u = {
        name = 'Find (bufd)'
      }
    },

    ['<leader>'] = {
      a = {
        name = 'Apps'
      },

      c = {
        name = 'Comments'
      },

      d = {
        name = 'Definitions'
      },

      e = {
        name = 'Diagnostics'
      },

      f = {
        name = 'Find (buf)'
      },

      F = 'which_key_ignore',

      g = {
        name = 'Git'
      },

      h = {
        name = 'History'
      },

      i = {
        name = 'Slime'
      },

      l = "which_key_ignore",

      L = "which_key_ignore",

      n = {
        name = 'Navigation'
      },

      p = {
        name = 'Yank ring'
      },

      P = 'which_key_ignore',

      q = {
        name = 'Quit'
      },

      r = {
        name = 'Refactor'
      },

      s = {
        name = 'Find (cwd)'
      },

      t = {
        name = 'Buffers'
      },

      u = {
        name = 'Find (bufd)'
      },

      v = {
        name = 'Expand region'
      },

      w = {
        name = 'Windows'
      },

      x = {
        name = 'Text'
      },

      y = {
        name = 'Tabs'
      },

      z = {
        name = 'Vim'
      }
    }
  }

  which_key.register(to_register, { mode = 'n' })
  which_key.register(to_register, { mode = 'x' })
end
