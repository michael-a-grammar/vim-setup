return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with('s')

  set('c', telescope.quickfix,  'quickfix')
  set('g', telescope.git_files, 'git')
  set('l', telescope.loclist,   'loclist')
  set('m', telescope.marks,     'Marks')
  set('p', telescope.jumplist,  'Jumps')
  set('R', telescope.oldfiles,  'Recent files')
end
