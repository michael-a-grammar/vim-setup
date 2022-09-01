return function()
  local g = vim.g

  g.gundo_preview_bottom   = true
  g.gundo_right            = true
  g.gundo_help             = false
  g.gundo_map_move_older   = 'n'
  g.gundo_map_move_newer   = 'e'
  g.gundo_return_on_revert = true
  g.gundo_prefer_python3   = true
end
