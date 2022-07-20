return {
  coc = {
    document_symbols = require'telescope'.extensions.coc.document_symbols
  },
  lsp = {
    document_symbols = require'telescope.builtin'.lsp_document_symbols
  }
}
