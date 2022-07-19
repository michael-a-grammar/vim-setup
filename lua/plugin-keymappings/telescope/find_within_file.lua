return function(opts)
  local map              = require'milque.cartographer'.with.nx_leader_f
  local telescope        = require'telescope.builtin'
  local pp               = require'plugin-providers'
  local outline          = pp.get(opts, 'find_within_file', 'outline')
  local find_within_file = pp.get(opts, 'telescope', 'find_within_file')

  map()
  .use_f()
  .rhs
  .fn(telescope.current_buffer_fuzzy_find)
  .exe()

  map()
  .use_o()
  .rhs
  .provider(outline.toggle)
  .exe()

  map()
  .use_s()
  .rhs
  .provider(find_within_file.document_symbol)
  .exe()

  map()
  .use_t()
  .rhs
  .fn(telescope.treesitter)
  .exe()
end
