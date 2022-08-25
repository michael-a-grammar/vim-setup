return function()
  local set = require'milque.cartographer'.i

  set('<c-c>', '<plug>(NERDCommenterInsert)', 'Comment')
end
