return function()
  local g = vim.g

  g.airline_left_sep            = ''
  g.airline_right_sep           = ''
  g.airline_statusline_ontop    = false
  g.airline_powerline_fonts     = true
  g.airline_skip_empty_sections = true
  g.airline_theme               = E.airline_theme or E.colorscheme

  g['airline#extensions#tabline#enabled'] = false
end
