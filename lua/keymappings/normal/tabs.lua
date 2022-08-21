return function()
  local set = require'keymappings.helpers'.nx_leader_with('y')

  set('c', '<cmd>tabnew<cr>',      'New tab')
  set('d', '<cmd>tabclose<cr>',    'Close tab')
  set('f', '<cmd>tabfirst<cr>',    'First tab')
  set('l', '<cmd>tablast<cr>',     'Last tab')
  set('n', '<cmd>tabnext<cr>',     'Next tab')
  set('p', '<cmd>tabprevious<cr>', 'Previous tab')
end
