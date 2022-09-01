return function(opts)
  if opts.use.which_key then
    local which_key = require'which-key'

    which_key.setup{
      layout     = { align = "center" },
      hidden     = { '<Plug>' },
      key_labels = {
        ['<Down>']  = '',
        ['<Left>']  = '',
        ['<Up>']    = '',
        ['<Right>'] = ''
      },

      popup_mappings = {
        scroll_down = '<m-down>', 
        scroll_up   = '<m-up>', 
      }
    }

    which_key.register{
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
          name = 'Find within cwd'
        },

        u = {
          name = 'Find within bd'
        }
      },

      ['<leader>'] = {
        ['/'] = {
          name = 'Search'
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
          name = 'Find within buffer'
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
          name = 'Find within cwd'
        },

        t = {
          name = 'Buffers'
        },

        u = {
          name = 'Find within bd'
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
  end
end

