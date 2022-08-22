return function()
  local set      = require'keymappings.helpers'.nx_leader_with('r')
  local lsp      = vim.lsp.buf
  local codelens = vim.lsp.codelens

  set('c', codelens.run, 'Run codelens')
  set('f', lsp.format,   'Format')
  set('n', lsp.rename,   'Rename')
end
