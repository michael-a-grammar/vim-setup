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
        'TelescopePrompt',
        'qf'
      }
    }
  }

  local to_register = {
    ['<localleader>'] = {
      r = {
        name = 'Rust'
      },

      s = {
        name = 'Find (ft)'
      },

      u = {
        name = 'Find (ft, bufd)'
      }
    },

    ['<leader>'] = {
      a = {
        name = 'Apps'
      },

      c = {
        name = 'Code'
      },

      d = {
        name = 'Hop',

        s = {
          name = 'Over window'
        }
      },

      f = {
        name = 'Find (buf)'
      },

      g = {
        name = 'Git'
      },

      h = {
        name = 'History'
      },

      i = {
        name = 'Slime',
      },

      n = {
        name = 'Navigation'
      },

      p = {
        name = 'Yank ring'
      },

      q = {
        name = 'Quit'
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
