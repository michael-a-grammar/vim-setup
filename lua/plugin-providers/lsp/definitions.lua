local lsp = vim.lsp.buf

return {
  coc = {
    hover     = { cmd = "call CocActionAsync('definitionHover')"   },
    signature = { cmd = "call CocActionAsync('showSignatureHelp')" }
  },
  lsp = {
    hover     = lsp.hover,
    signature = lsp.signature_help
  }
}
