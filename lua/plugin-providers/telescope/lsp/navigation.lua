local telescope     = require'telescope.builtin'

return {
  coc = {
    definitions       = { cmd = 'Telescope coc definitions'       },
    implementations   = { cmd = 'Telescope coc implementations'   },
    references        = { cmd = 'Telescope coc references'        },
    workspace_symbols = { cmd = 'Telescope coc workspace_symbols' }
  },
  lsp = {
    definitions       = telescope.lsp_definitions,
    implementations   = telescope.lsp_implementations,
    references        = telescope.lsp_references,
    workspace_symbols = telescope.lsp_workspace_symbols
  }
}
