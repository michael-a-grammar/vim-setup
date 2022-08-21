return function()
  local telescope = require'telescope.builtin'
  local set       = require'keymappings.helpers'.nx_leader_with('t')

  set('t', telescope.buffers, 'Buffers')
end
