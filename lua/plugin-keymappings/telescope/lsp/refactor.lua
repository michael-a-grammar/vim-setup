return function(opts)
  if opts.use.coc then
    local telescope_coc = require'telescope'.extensions.coc
    local r             = require'milque.cartographer'.with.nx_leader_r

    r()
    .use_A()
    .rhs
    .fn(telescope_coc.line_code_actions)
    .exe()

    r()
    .use_a()
    .rhs
    .fn(telescope_coc.file_code_actions)
    .exe()
  end
end
