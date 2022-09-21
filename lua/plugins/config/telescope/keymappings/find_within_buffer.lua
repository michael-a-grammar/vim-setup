return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with'f'

  set('f', telescope.current_buffer_fuzzy_find, 'Fuzzy find')
  set('s', telescope.lsp_document_symbols,      'Document symbols')
  set('t', telescope.treesitter,                'Treesitter')
end
