local lsp = vim.lsp.buf

return {
  refactor = {
    codelens = lsp.codelens.run,
    format   = lsp.format,
    refactor = lsp.code_action,
    rename   = lsp.rename
  }
}
