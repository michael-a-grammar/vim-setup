return {
  'folke/which-key.nvim',

  opts = function()
    local opts  = require'vamp.opts'
    local icons = opts.icons

    return {
      layout = {
        align = opts.plugins.which_key.alignment,
      },

      hidden = { '<Plug>' },

      key_labels = {
        ['<space>'] = icons.keys.space,
        ['<bs>']    = icons.keys.backspace,
        ['<down>']  = icons.keys.down,
        ['<left>']  = icons.keys.left,
        ['<up>']    = icons.keys.up,
        ['<right>'] = icons.keys.right,
        ['<Tab>']   = icons.keys.tab,
      },

      popup_mappings = {
        scroll_down = '<c-p>',
        scroll_up   = '<c-P>',
      },

      disable = {
        filetypes = {
          'TelescopePrompt',
          'qf'
        },
      },
    }
  end,

  config = function(_, opts)
    local icons     = require'vamp.opts'.icons
    local which_key = require'which-key'

    which_key.setup(opts)

    local to_register = {
      ['<bs>'] = {
        w = {
          name = 'Over window',
        },
      },

      ['<localleader>'] = {
        e = {
          name = '',

          n = {
            name = 'New file'
          },

          p = {
            name = 'Pipes'
          },

          r = {
            name = 'Restart LSP'
          },
        },

        r = {
          name = '',
        },
      },

      ['<leader>'] = {
        a = {
          name = 'Unassigned',
        },

        b = {
          name = 'Unassigned',
        },

        -- c = {
          -- name = 'Unassigned',
        -- },

        d = {
          name = 'Diagnostics',
        },

        e = {
          name = 'File',
        },

        f = {
          name = 'Yank ring',
        },

        g = {
          name = 'Git',
        },

        h = {
          name = 'History',
        },

        i = {
          name = 'LSP',
        },

        j = {
          name = 'Unassigned',
        },

        k = {
          name = 'Toggles',
        },

        -- l = {
          -- name = 'Unassigned',
        -- },

        -- m = {
        -- name = 'Unassigned'
        -- },

        n = {
          name = 'Buffer',
        },

        o = {
          name = 'Unassigned',
        },

        -- p = {
          -- name = 'Unassigned',
        -- },

        q = {
          name = 'Quit',
        },

        r = {
          name = 'Terminal',
        },

        s = {
          name = icons.legends.current_working_directory .. ' Find',

          t = {
            name = icons.legends.file_type .. ' Find',
          },
        },

        t = {
          name = 'Buffers',
        },

        u = {
          name = icons.legends.buffer_directory .. ' Find',

          t = {
            name = icons.legends.file_type .. 'Find',
          },
        },

        v = {
          name = 'Expand region',
        },

        w = {
          name = 'Windows',
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

    which_key.register(to_register, { mode = 'n', })
    which_key.register(to_register, { mode = 'x', })
  end,
}
