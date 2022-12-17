return function()
  local api = vim.api
  local fn  = vim.fn
  local g   = vim.g
  local map = require'elden.plugins.cartographer'.map

  g['fern#renderer'] = 'nerdfont'

  local events_augroup = api.nvim_create_augroup('file_type_events', {})

  api.nvim_create_autocmd('FileType', {
    group = events_augroup,
    pattern = 'fern,startify',
    callback = function()
      fn['glyph_palette#apply']()
    end
  })

  map(function()
    nx_leader {
      'l', exe 'Fern . -drawer -toggle -reveal=%:p', 'Fern (cwd)'
    }
  end)
end
