local telescope     = require'telescope.builtin'
local telescope_coc = require'telescope'.extensions.coc

return {
  coc = {
    diagnostics = telescope_coc.diagnostics
  },
  lsp = {
    diagnostics = telescope.diagnostics
  }
}
