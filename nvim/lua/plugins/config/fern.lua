return function()
  local api = vim.api
  local fn  = vim.fn
  local g   = vim.g
  local map = require'bundled.cartographer'.map

  g['fern#renderer'] = 'nerdfont'

  local events_augroup = api.nvim_create_augroup('fern_file_type_events', {})

  api.nvim_create_autocmd('FileType', {
    group    = events_augroup,
    pattern  = 'fern,startify',
    callback = function()
      fn['glyph_palette#apply']()
    end
  })

  api.nvim_create_autocmd('FileType', {
    group    = events_augroup,
    pattern  = 'fern',
    callback = function()
      vim.opt_local.number         = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn     = 'no'

      map(function()
        vim.keymap.set(
          'n',
          '<plug>(fern-quit-or-close-preview)',
          'fern_preview#smart_preview(":call fern_preview#close()<cr>", ":q<cr>")',
          {
            desc   = '...',
            buffer = true,
            expr   = true
          })

        b.n {
          ctrl 'd', plug 'fern-action-preview:scroll:down:half', 'Preview scroll down',
          ctrl 'u', plug 'fern-action-preview:scroll:up:half',   'Preview scroll up',

          'o', plug 'fern-action-preview:toggle',      'Preview',
          'O', plug 'fern-action-preview:auto:toggle', 'Preview toggle',

          'q', plug 'fern-quit-or-close-preview', 'Quit'
        }

        b.n_leader {
          'l', ctrl 'w' :with 'p', 'Previous window'
        }
      end)
    end
  })

  map(function()
    nx_leader {
      'l', exe 'Fern . -drawer -reveal=%:p',         'Locate file within fern',
      'L', exe 'Fern . -drawer -toggle -reveal=%:p', 'Toggle fern'
    }
  end)
end
