return {
  'folke/which-key.nvim',

  opts = {
    disable = {
      filetypes = {
        'neo-tree',
        'neo-tree-popup',
        'notify',
        'qf',
        'undotree',
        'NeogitCommandHistory',
        'NeogitCommitView',
        'NeogitPopup',
        'NeogitStatus',
        'Outline',
        'TelescopePrompt',
      },
    },

    hidden = { '<Plug>' },

    icons = {
      breadcrumb = ' ' .. '' .. ' ',
      group = '',
    },

    key_labels = {
      ['<space>'] = '󱁐',
      ['<bs>'] = '󰁮',
      ['<down>'] = '',
      ['<left>'] = '',
      ['<up>'] = '',
      ['<right>'] = '',
      ['<Tab>'] = '󰌒',
    },

    layout = {
      align = 'left',
    },

    popup_mappings = {
      scroll_up = '<c-f>',
      scroll_down = '<c-p>',
    },

    show_help = false,
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
          name = 'Notifications',
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
          name = 'History / Navigate',
        },

        g = {
          name = '',

          s = {
            name = 'Search',
          },
        },

        h = {
          name = '',
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
          name = 'Local',
        },

        n = {
          name = 'Buffer',

          g = {
            name = 'Git',

            t = {
              name = 'Toggles',
            },
          },

          d = {
            name = 'Delete buffer',
          },

          o = {
            name = 'Outline',
          },
        },

        o = {
          name = 'Unassigned',
        },

        p = {
          name = 'Edit',

          y = {
            name = 'Yank ring',
          },
        },

        q = {
          name = '󱠡',
        },

        r = {
          name = '',
        },

        s = {
          name = '' .. ' Find',

          t = {
            name = '' .. ' Find',
          },
        },

        t = {
          name = 'Buffers',

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
            name = 'New window',
          },

          m = {
            name = 'Move window',
          },

          n = {
            name = 'Navigate windows',
          },

          o = {
            name = 'Rotate window',
          },

          r = {
            name = 'Resize window',
          },
        },

        x = {
          name = 'Text',
        },

        y = {
          name = 'Tabs',
        },

        z = {
          name = '',
        },
      },
    }

    for index = 2, 5, 1 do
      local terminal_index = tostring(index)

      to_register['<leader>'].r[terminal_index] = {
        name = 'Terminal ' .. terminal_index,
      }
    end

    which_key.register(to_register, { mode = 'n' })
    which_key.register(to_register, { mode = 'x' })
  end,
}
