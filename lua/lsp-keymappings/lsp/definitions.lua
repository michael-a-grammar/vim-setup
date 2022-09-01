return function()
  local set = require'milque.cartographer'.nx_leader_with'd'
  local lsp = vim.lsp.buf

  set('h', lsp.hover, 'Hover')
  set('s', lsp.signature_help, 'Signature')
end
