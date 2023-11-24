return function()
  local which_key = require'which-key'

  which_key.setup {
    layout     = { align = "left" },
    hidden     = { '<Plug>' },
    key_labels = {
      ['<space>'] = '',
      ['<bs>']    = '󰁮',
      ['<Tab>']   = '󰌒',
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
      },
    },
  }

  local to_register = {
    -- TODO: Why is this commented out?
    -- ['<localleader>'] = {
    -- },

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
        name = 'LSP',
      },

      d = {
        name = 'Unassigned',
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

      m = {
        name = 'Local leader',

        e = {
          name = 'Elixir'
        },

        r = {
          name = 'Rust',
        },
      },

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
