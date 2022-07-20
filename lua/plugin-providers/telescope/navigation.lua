local telescope     = require'telescope.builtin'
local telescope_coc = require'telescope'.extensions.coc

return {
  coc = {
    definitions     = telescope_coc.definitions,
    implementations = telescope_coc.implementations,
    references      = telescope_coc.references
  },
  lsp = {
    definitions      = telescope.lsp_definitions,
    implementations  = telescope.lsp_implementations,
    references       = telescope.lsp_references,
    type_definitions = telescope.lsp_type_definitions
  }
}
