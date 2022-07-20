return function(opts)
  local f                = require'milque.cartographer'.with.nx_leader_f
  local telescope        = require'telescope.builtin'
  local pp               = require'plugin-providers'
  local find_within_file = pp.get(opts, 'telescope', 'find_within_file')

  f()
  .use_f()
  .rhs
  .fn(telescope.current_buffer_fuzzy_find)
  .exe()

  f()
  .use_s()
  .rhs
  .provider(find_within_file.document_symbols)
  .exe()

  f()
  .use_t()
  .rhs
  .fn(telescope.treesitter)
  .exe()
end
