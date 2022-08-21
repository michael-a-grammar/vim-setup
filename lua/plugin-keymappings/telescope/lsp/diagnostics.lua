return function()
  local telescope = require'telescope.builtin'
  local set       = require'keymappings.helpers'.nx_leader_with('e')

  set('e', telescope.diagnostics, 'Diagnostics')
end
