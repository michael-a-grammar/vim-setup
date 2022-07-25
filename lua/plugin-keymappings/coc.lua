return function(opts)
  if opts.use.coc then
    local f = require'milque.cartographer'.with.nx_leader_f

    f()
    .use_o()
    .rhs
    .cmd('CocList outline')
    .exe()
  end
end
