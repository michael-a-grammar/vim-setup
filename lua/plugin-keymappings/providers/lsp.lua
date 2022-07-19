return function()
  local lsp        = vim.lsp.buf
  local diagnostic = vim.diagnostic

  return {
    definitions = {
      hover     = lsp.hover,
      signature = lsp.signature_help
    },
    diagnostics = {
      info       = diagnostic.open_float,
      next       = diagnostic.goto_next,
      next_error = diagnostic.goto_next,
      prev       = diagnostic.goto_prev
      prev_error = diagnostic.goto_prev,
      setloclist = diagnostic.setloclist
    },
    find_within_file = {
      outline = { cmd = 'CocList outline' }
    },
    refactor = {
      codelens = lsp.codelens.run,
      format = lsp.format,
      refactor = lsp.code_action,
      rename = lsp.rename
    }
  }
end
