return function(opts)
  if opts.use.which_key then
    local which_key = require'which-key'

    which_key.setup{

    }

    which_key.register{
      [','] = {
        s = {
          name = 'Sneak'
        },
      },

      ['<localleader>'] = {
        p = {
          name = 'Pipes'
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

        g = {
          name = 'Git'
        },

        h = {
          name = 'History'
        },

        i = {
          name = 'Slime'
        },

        n = {
          name = 'Navigation'
        },

        p = {
          name = 'Yank ring'
        },

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

