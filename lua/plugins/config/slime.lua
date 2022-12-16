return function()
  local env   = vim.env
  local g     = vim.g
  local split = vim.split
  local map   = require'elden.cartographer'.map

  g.slime_no_mappings      = true
  g.slime_dont_ask_default = true

  if env.TMUX then
    g.slime_target = 'tmux'

    g.slime_default_config = {
      socket_name = split(env.TMUX, ',')[1],
      target_pane = ':0.{last}'
    }
  end

  map(function()
    nx_leader_with 'i' {
      'a', exe '%SlimeSend',           'Send buffer to REPL',
      'i', '<plug>SlimeParagraphSend', 'Send to REPL',
      'v', '<plug>SlimeConfig',        'Configure REPL'
    }
  end)
end
