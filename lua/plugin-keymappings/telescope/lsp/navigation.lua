return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with('n')

  set('d', telescope.lsp_definitions,               'Definitions')
  set('i', telescope.lsp_implementations,           'Implementations')
  set('s', telescope.lsp_workspace_symbols,         'Workspace symbols')
  set('S', telescope.lsp_dynamic_workspace_symbols, 'Dynamic workspace symbols')
  set('t', telescope.lsp_type_definitions,          'Type definitions')
  set('u', telescope.lsp_references,                'References')
end
