local telescope     = require'telescope.builtin'
local telescope_coc = require'telescope'.extensions.coc

return {
  coc = {
    definitions       = telescope_coc.definitions,
    implementations   = telescope_coc.implementations,
    references        = telescope_coc.references,
    workspace_symbols = telescope_coc.workspace_symbols
  },
  lsp = {
    definitions       = telescope.lsp_definitions,
    implementations   = telescope.lsp_implementations,
    references        = telescope.lsp_references,
    workspace_symbols = telescope.lsp_workspace_symbols
  }
}
