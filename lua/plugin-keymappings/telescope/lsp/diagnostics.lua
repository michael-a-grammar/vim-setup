return function(opts)
  local e           = require'milque.cartographer'.with.nx_leader_e
  local pp          = require'plugin-providers'
  local diagnostics = pp.get(opts, 'telescope', 'lsp.diagnostics')

  if opts.use.coc then
    e()
    .use_E()
    .rhs
    .fn(require'telescope'.extensions.coc.workspace_diagnostics)
  end

  e()
  .use_e()
  .rhs
  .provider(diagnostics.diagnostics)
  .exe()
end
