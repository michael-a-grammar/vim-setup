return function(opts)
  local f       = require'milque.cartographer'.with.nx_leader_f
  local pp      = require'plugin-providers'
  local outline = pp.get(opts, 'find_within_file', 'outline')

  f()
  .use_o()
  .rhs
  .provider(outline.toggle)
  .exe()
end
