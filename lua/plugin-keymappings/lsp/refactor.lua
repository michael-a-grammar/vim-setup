return function(opts)
  local r        = require'milque.cartographer'.with.nx_leader_r
  local pp       = require'plugin-providers'
  local refactor = pp.get(opts, 'lsp', 'refactor')

  if opts.use.lsp then
    r()
    .use_c()
    .rhs
    .provider(vim.lsp.codelens.run)
    .exe()
  end

  r()
  .use_f()
  .rhs
  .provider(refactor.format)
  .exe()

  r()
  .use_n()
  .rhs
  .provider(refactor.rename)
  .exe()

  r()
  .use_r()
  .rhs
  .provider(refactor.refactor)
  .exe()
end
