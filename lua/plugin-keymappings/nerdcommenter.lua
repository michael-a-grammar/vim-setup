return function()
  local set = require'keymappings.helpers'.i

  set('<c-c>', '<plug>(NERDCommenterInsert)', 'Comment')
end
