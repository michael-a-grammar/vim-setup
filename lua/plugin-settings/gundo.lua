return function()
  local g = vim.g

  g.gundo_preview_bottom   = 1
  g.gundo_right            = 1
  g.gundo_help             = 0
  g.gundo_map_move_older   = 'p'
  g.gundo_map_move_newer   = 'f'
  g.gundo_return_on_revert = 1
  g.gundo_prefer_python3   = 1
end
