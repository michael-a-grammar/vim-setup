return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with('s')

  set('c', telescope.quickfix,  'Quickfix')
  set('g', telescope.git_files, 'Git')
  set('l', telescope.loclist,   'Loclist')
  set('m', telescope.marks,     'Marks')
  set('p', telescope.jumplist,  'Jumps')
  set('R', telescope.oldfiles,  'Recent files')
end
