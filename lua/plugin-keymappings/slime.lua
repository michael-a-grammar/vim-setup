return function()
  local set = require'keymappings.helpers'.nx_leader_with('i')

  set('i', '<plug>SlimeParagraphSend',   'Send to REPL')
  set('v', '<plug>SlimeParagraphConfig', 'Configure REPL')
end
