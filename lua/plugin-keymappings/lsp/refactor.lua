return function()
  local set      = require'milque.cartographer'.nx_leader_with('r')
  local lsp      = vim.lsp.buf
  local codelens = vim.lsp.codelens

  set('c', codelens.run,   'Run codelens')
  set('f', lsp.formatting, 'Format')
  set('n', lsp.rename,     'Rename')
end
