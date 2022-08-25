return function()
  local telescope = require('telescope.builtin')
  local set       = require'milque.cartographer'.nx_local_leader

  local elixir_find_files = function()
    telescope.find_files({
      prompt_title = 'Find Files (Elixir)',
      find_command = { 'rg', '--type', 'elixir', '--files' }
    })
  end

  set('f',  '<cmd>%!mix format - <cr>',            'Mix format')
  set('pf', '<cmd>ElixirFromPipe<cr>',             'From pipe')
  set('pt', '<cmd>ElixirToPipe<cr>',               'To pipe')
  set('e',  '<cmd>ElixirExpandMacro<cr>',          'Expand macro')



  set('f',  [[<cmd>call Slime('iex', 'exs')<cr>]], 'IEx')
end

