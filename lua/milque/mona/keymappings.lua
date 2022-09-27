return function()
  local sludge = require'milque.sludge'
  local map    = require'milque.cartographer'.map

  map(function()
    nx_local_leader {
      'f',  exe('%!mix format -'),    'Mix format',
      'e',  exe('ElixirExpandMacro'), 'Expand macro',

      'i',
      function()
        sludge.start('iex', 'exs', function()
          local leader = vim.g.mapleader

          if leader == ' ' then
            leader = '1' .. leader
          end

          vim.api.nvim_exec('normal ' .. leader .. 'i', false)
        end)
      end,
      'IEx'
    }

    nx_local_leader_with 'p' {
      'f', exe('ElixirFromPipe'), 'From pipe',
      't', exe('ElixirToPipe'),   'To pipe'
    }
  end)
end
