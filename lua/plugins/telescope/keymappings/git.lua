return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with('g')

  set('b', telescope.git_branches, 'Branches')
  set('c', telescope.git_bcommits, 'Branch commits')
  set('C', telescope.git_commits,  'Commits')
  set('f', telescope.git_files,    'Files')
  set('g', telescope.git_status,   'Status')
  set('s', telescope.git_stash,    'Stash')
end
