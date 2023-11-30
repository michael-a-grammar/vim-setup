return function()
  local which_key = require'which-key'
  local icons     = E.icons

  which_key.setup {
    layout = {
      align = opts.alignment,
    },

    hidden = { '<Plug>' },

    key_labels = {
      ['<space>'] = icons.keys.space,
      ['<bs>']    = icons.keys.backspace,
      ['<tab>']   = icons.keys.tab,
      ['<down>']  = icons.keys.down,
      ['<left>']  = icons.keys.left,
      ['<up>']    = icons.keys.up,
      ['<right>'] = icons.keys.right,
    },

    popup_mappings = {
      scroll_down = '<m-down>',
      scroll_up   = '<m-up>',
    },

    disable = {
      filetypes = {
        'TelescopePrompt',
        'qf'
      },
    },
  }

  local to_register = {
    ['<bs>'] = {
      w = {
        name = 'Over window',
      },
    },

    ['<localleader>'] = {
      e = {
        name = 'Elixir',

        i = {
          name = 'Pipes'
        },

        p = {
          name = 'Project'
        },
      },

      r = {
        name = 'Rust',
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
        name = 'LSP',
      },

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
        name = 'Code',
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
        name = 'Find w/i cwd',

        t = {
          name = 'Find w/ft',
        },
      },

      t = {
        name = 'Buffers',
      },

      u = {
        name = 'Find w/i bufd',

        t = {
          name = 'Find w/ft',
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
      }
    }
  }

  which_key.register(to_register, { mode = 'n', })
  which_key.register(to_register, { mode = 'x', })
end
