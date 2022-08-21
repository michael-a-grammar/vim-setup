return function()
  local set        = require'keymappings.helpers'.nx_leader_with('e')
  local diagnostic = vim.diagnostic

  set('c', diagnostic.setloclist,    'Set loclist with diagnostics')
  set('d', diagnostics.open_float,   'Info')
  set('n', diagnostic.goto_next,     'Go to next diagnostic')
  set('p', diagnostic.goto_previous, 'Go to previous diagnostic')
end
