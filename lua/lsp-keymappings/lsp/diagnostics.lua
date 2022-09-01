return function()
  local set        = require'milque.cartographer'.b.nx_leader_with'e'
  local diagnostic = vim.diagnostic

  set('c', diagnostic.setloclist, 'Set loclist with diagnostics')
  set('d', diagnostic.open_float, 'Info')
  set('n', diagnostic.goto_next,  'Go to next diagnostic')
  set('p', diagnostic.goto_prev,  'Go to previous diagnostic')
end
