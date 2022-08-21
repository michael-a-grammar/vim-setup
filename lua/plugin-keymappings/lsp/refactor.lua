return function()
  local set = require'keymappings.helpers'.nx_leader_with('r')
  local lsp = vim.lsp.buf

  set('c', lsp.codelens.run, 'Run codelens')
  set('f', lsp.format,       'Format')
  set('n', lsp.rename,       'Rename')
  set('r', lsp.refactor,     'Refactor')
end
