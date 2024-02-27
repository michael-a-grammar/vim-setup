return {
  'jpalardy/vim-slime',

  init = function()
    local env   = vim.env
    local g     = vim.g
    local split = vim.split
    local map   = require'elden.cartographer'.map

    g.slime_no_mappings = true

    if env.TMUX then
      g.slime_dont_ask_default = true
      g.slime_target           = 'tmux'

      g.slime_default_config = {
        socket_name = split(env.TMUX, ',')[1],
        target_pane = ':0.{last}',
      }
    elseif env.KITTY_LISTEN_ON then
      g.slime_target = 'kitty'

      g.slime_default_config = {
        listen_on = 'unix:/tmp/mykitty',
      }
    end

    map(function()
      nx_leader_with 'i' {
        '%', exe '%SlimeSend',           'Send buffer to REPL',
        'c', '<plug>SlimeConfig',        'Configure REPL',
        'i', exe 'SlimeSendCurrentLine', 'Send line to REPL',
        'p', '<plug>SlimeParagraphSend', 'Send paragraph to REPL',
        'r', '<plug>SlimeRegionSend',    'Send region to REPL',
      }

      x_leader_with 'i' {
        'v', exe "'<,'>SlimeSend", 'Send selection to REPL'
      }
    end)
  end
}