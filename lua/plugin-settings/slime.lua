local env   = vim.env
local g     = vim.g
local split = vim.split
local map   = require'milque.cartographer'.map

return function()
  g.slime_target      = 'tmux'
  g.slime_no_mappings = 1

  if env.TMUX then
    g.slime_default_config = {
      socket_name = split(env.TMUX, ',')[1],
      target_pane = ':0.{last}'
    }
  end

  map()
    .modes.mode_n().mode_x()
    .lhs.use_leader().use_ii()
    .rhs.plug('SlimeParagraphSend')
  .exe()

  map()
    .modes.mode_n().mode_x()
    .lhs.use_leader().use_iv()
    .rhs.plug('SlimeParagraphConfig')
  .exe()
end
