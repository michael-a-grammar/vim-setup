return function()
  local set = require'keymappings.helpers'.nx_leader_with('w')

  set('.', '<c-w>>', 'Increase window width')
  set(',', '<c-w><', 'Decrease window width')
  set('|', '<c-w>|', 'Maximise window width')
  set('+', '<c-w>+', 'Increase window height')
  set('-', '<c-w>-', 'Decrease window height')
  set('_', '<c-w>_', 'Maximise window height')
  set('=', '<c-w>=', 'Equalise window size')

  set('d', '<cmd>close<cr>', 'Close window')
  set('h', '<cmd>only<cr>',  'Close other windows')

  set('e', '<c-w>j', 'Move to bottom window')
  set('i', '<c-w>k', 'Move to top window')
  set('n', '<c-w>h', 'Move to left window')
  set('o', '<c-w>l', 'Move to right window')
  set('r', '<c-w>r', 'Rotate window downwards/rightwards')
  set('x', '<c-w>x', 'Exchange window')

  set('E', '<c-w>J', 'Move window to bottom')
  set('I', '<c-w>K', 'Move window to top')
  set('N', '<c-w>H', 'Move window to left')
  set('O', '<c-w>L', 'Move window to right')
  set('R', '<c-w>R', 'Rotate window upwards/leftwards')

  set('s', '<cmd>vsplit<cr>',    'Split window vertically')
  set('S', '<cmd>split<cr>',     'Split window horizontally')
  set('t', '<cmd>tab split<cr>', 'Open window in new tab')
end
