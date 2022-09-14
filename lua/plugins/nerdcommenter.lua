return function()
  local set = require'milque.cartographer'.i

  vim.g.NERDCreateDefaultMappings = false

  set('<c-c>', '<plug>(NERDCommenterInsert)', 'Comment')
end
