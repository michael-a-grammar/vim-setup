return function()
  local lsp = vim.lsp.buf

  return {
    definitions = {
      hover     = lsp.hover,
      signature = lsp.signature_help
    }
  }
end
