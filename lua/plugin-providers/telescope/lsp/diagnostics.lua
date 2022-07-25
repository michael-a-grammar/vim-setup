local telescope     = require'telescope.builtin'

return {
  coc = {
    diagnostics = { cmd = 'Telescope coc diagnostics' }
  },
  lsp = {
    diagnostics = telescope.diagnostics
  }
}
