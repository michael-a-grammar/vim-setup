return function()
  local map = require'milque.cartographer'.map

  vim.g.NERDCreateDefaultMappings = false

  map(function()
    nx_leader_with 'i' {
      ctrl('c'), plug('NERDCommenterInsert'), 'Comment'
    }
  end)
end
