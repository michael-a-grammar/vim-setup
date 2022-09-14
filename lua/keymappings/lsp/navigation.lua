return function()
  local set = require'milque.cartographer'.nx
  local lsp = vim.lsp.buf

  set('gd', lsp.definition,      'Go to definition')
  set('gD', lsp.declaration,     'Go to declaration')
  set('gm', lsp.implementation,  'Go to implementation')
  set('gr', lsp.references,      'Go to references')
  set('gt', lsp.type_definition, 'Go to type definition')
end
