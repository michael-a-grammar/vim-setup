return function()
  local env   = vim.env
  local g     = vim.g
  local split = vim.split

  g.slime_no_mappings = true

  if env.TMUX then
    g.slime_target = 'tmux'

    g.slime_default_config = {
      socket_name = split(env.TMUX, ',')[1],
      target_pane = ':0.{last}'
    }
  end
end
