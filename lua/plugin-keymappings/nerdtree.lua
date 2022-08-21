return function()
  local set = require'keymappings.helpers'.nx_leader

  set('l', 'NERDTreeFind',  'Open directory tree at current file')
  set('L', 'NERDTreeClose', 'Close directory tree')
end
