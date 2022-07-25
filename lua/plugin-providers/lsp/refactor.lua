local lsp = vim.lsp.buf

return {
  coc ={
    format   = { plug = 'coc-format'   },
    rename   = { plug = 'coc-rename'   },
    refactor = { plug = 'coc-refactor' }
  },
  lsp = {
    format   = lsp.format,
    refactor = lsp.code_action,
    rename   = lsp.rename
  }
}
