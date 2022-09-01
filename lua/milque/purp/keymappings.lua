return function(opts)
  local sludge = require'milque.sludge'
  local set    = require'milque.cartographer'.nx_local_leader

  set('f',  '<cmd>%!mix format - <cr>', 'Mix format')

  if opts.use.elixir_nvim then
    set('pf', '<cmd>ElixirFromPipe<cr>',    'From pipe')
    set('pt', '<cmd>ElixirToPipe<cr>',      'To pipe')
    set('e',  '<cmd>ElixirExpandMacro<cr>', 'Expand macro')
  end

  set('i', function()
    sludge.start('iex', 'exs', 'i')
  end, 'IEx')
end

