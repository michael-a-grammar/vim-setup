return {
  'folke/which-key.nvim',

  opts = {
    layout = {
      align = 'left',
    },

    hidden = { '<Plug>' },

    key_labels = {
      ['<space>'] = '󰭟',
      ['<bs>'] = '󰁮',
      ['<down>'] = '',
      ['<left>'] = '',
      ['<up>'] = '',
      ['<right>'] = '',
      ['<Tab>'] = '󰌒',
    },

    popup_mappings = {
      scroll_up = '<c-f>',
      scroll_down = '<c-p>',
    },

    disable = {
      filetypes = {
        'qf',
        'TelescopePrompt',
      },
    },
  },

  config = function(_, opts)
    local which_key = require('which-key')

    which_key.setup(opts)

    local to_register = {
      ['<bs>'] = {
        w = {
          name = 'Over window',
        },
      },

      ['<leader>'] = {
        a = {
          name = 'Unassigned',
        },

        b = {
          name = 'Unassigned',
        },

        c = {
          name = 'Slime',
        },

        d = {
          name = 'Diagnostics',
        },

        e = {
          name = 'LSP',
        },

        f = {
          name = 'Search',
        },

        g = {
          name = 'Git',

          g = {
            name = 'Browse',
          },
        },

        h = {
          name = 'Unassigned',
        },

        i = {
          name = 'Unassigned',
        },

        j = {
          name = 'Unassigned',
        },

        k = {
          name = 'Toggles',
        },

        l = {
          name = 'Unassigned',
        },

        L = {
          name = 'Unassigned',
        },

        m = {
          name = 'Unassigned',
        },

        n = {
          name = 'Buffer',

          g = {
            name = 'Git',

            t = {
              name = 'Toggles',
            },
          },

          o = {
            name = 'Outline',
          },
        },

        o = {
          name = 'Unassigned',
        },

        p = {
          name = 'Editing',
        },

        q = {
          name = 'Quit',
        },

        r = {
          name = 'Terminal',
        },

        s = {
          name = '' .. ' Find',

          t = {
            name = '' .. ' Find',
          },
        },

        t = {
          name = 'Buffers',

          d = {
            name = 'Delete buffer',
          },

          x = {
            name = 'Delete other buffers',
          },
        },

        u = {
          name = '' .. ' Find',

          t = {
            name = '' .. ' Find',
          },
        },

        v = {
          name = 'Unassigned',
        },

        w = {
          name = 'Windows',

          c = {
            name = 'Jump',
          },

          m = {
            name = 'Move',
          },

          o = {
            name = 'Rotate',
          },

          r = {
            name = 'Resize',
          },

          s = {
            name = 'Split',
          },
        },

        x = {
          name = 'Text',
        },

        y = {
          name = 'Tabs',
        },

        z = {
          name = 'Vim',
        },
      },
    }

    which_key.register(to_register, { mode = 'n' })
    which_key.register(to_register, { mode = 'x' })
  end,
}
