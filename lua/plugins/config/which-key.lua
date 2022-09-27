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
        'nerdtree',
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
        name = 'ﳤ'
      },

      s = {
        name = 'Find within 華'
      },

      u = {
        name = 'Find within ﬘ '
      }
    },

    ['<leader>'] = {
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
        name = 'Find within ﬘'
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

      r = {
        name = 'Refactor'
      },

      s = {
        name = 'Find within 華'
      },

      t = {
        name = 'Buffers'
      },

      u = {
        name = 'Find within ﬘ '
      },

      v = {
        name = 'Visual'
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
