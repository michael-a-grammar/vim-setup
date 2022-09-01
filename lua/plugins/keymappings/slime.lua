return function()
  local set = require'milque.cartographer'.nx_leader_with'i'

  set('i', '<plug>(SlimeParagraphSend)',   'Send to REPL')
  set('v', '<plug>(SlimeParagraphConfig)', 'Configure REPL')
end
