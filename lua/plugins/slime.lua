return function()
  local env   = vim.env
  local g     = vim.g
  local split = vim.split
  local set   = require'milque.cartographer'.nx_leader_with'i'

  g.slime_no_mappings = true

  if env.TMUX then
    g.slime_target = 'tmux'

    g.slime_default_config = {
      socket_name = split(env.TMUX, ',')[1],
      target_pane = ':0.{last}'
    }
  end

  set('i', '<plug>(SlimeParagraphSend)',   'Send to REPL')
  set('v', '<plug>(SlimeParagraphConfig)', 'Configure REPL')
end
