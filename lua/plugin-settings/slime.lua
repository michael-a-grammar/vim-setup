local env   = vim.env
local g     = vim.g
local split = vim.split

return function()
  g.slime_target      = 'tmux'
  g.slime_no_mappings = 1

  g.slime_default_config = {
    socket_name = split(env.TMUX, ',')[1],
    target_pane = ':0.{last}'
  }
end
