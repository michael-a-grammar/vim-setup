return function()
  local set = require'keymappings.helpers'.nx_leader_with('v')

  set('v', '<c-v>', 'Visual block')
end
