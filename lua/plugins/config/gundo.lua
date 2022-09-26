return function()
  local g   = vim.g
  local map = require'milque.cartographer'.map

  g.gundo_preview_bottom   = true
  g.gundo_right            = true
  g.gundo_help             = false
  g.gundo_map_move_older   = 'n'
  g.gundo_map_move_newer   = 'e'
  g.gundo_return_on_revert = true
  g.gundo_prefer_python3   = true

  map(function()
    nx_leader_with 'h' {
      'u', exe('GundoToggle'), 'Undo tree'
    }
  end)
end
