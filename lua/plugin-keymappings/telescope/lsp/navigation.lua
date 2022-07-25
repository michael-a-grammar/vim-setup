return function(opts)
  local telescope  = require'telescope.builtin'
  local n          = require'milque.cartographer'.with.nx_leader_n
  local pp         = require'plugin-providers'
  local navigation = pp.get(opts, 'telescope', 'lsp.navigation')

  n()
  .use_d()
  .rhs
  .provider(navigation.definitions)
  .exe()

  n()
  .use_i()
  .rhs
  .provider(navigation.implementations)
  .exe()

  if opts.use.lsp then
    n()
    .use_S()
    .rhs
    .provider(telescope.lsp_dynamic_workspace_symbols)
    .exe()
  end

  n()
  .use_s()
  .rhs
  .provider(navigation.workspace_symbols)
  .exe()

  if opts.use.lsp then
    n()
    .use_t()
    .rhs
    .fn(telescope.lsp_type_definitions)
    .exe()
  end

  n()
  .use_u()
  .rhs
  .provider(navigation.references)
  .exe()
end
