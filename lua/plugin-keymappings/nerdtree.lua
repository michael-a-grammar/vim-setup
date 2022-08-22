return function()
  local set = require'keymappings.helpers'.nx_leader

  set('l', '<cmd>NERDTreeFind<cr>',  'Open directory tree at current file')
  set('L', '<cmd>NERDTreeClose<cr>', 'Close directory tree')
end
