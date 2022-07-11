return function(opts)
  if opts.use.airline then
    local g = vim.g

    g.airline_left_sep            = ''
    g.airline_right_sep           = ''
    g.airline_powerline_fonts     = 1
    g.airline_skip_empty_sections = 1
    g.airline_theme               = opts:get_cs()

    g['airline#extensions#tabline#enabled'] = 1
  end
end
