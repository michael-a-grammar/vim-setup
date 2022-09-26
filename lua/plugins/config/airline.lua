local g    = vim.g
local opts = require 'opts'

g.airline_left_sep            = ''
g.airline_right_sep           = ''
g.airline_statusline_ontop    = false
g.airline_powerline_fonts     = true
g.airline_skip_empty_sections = true
g.airline_theme               = opts.colorscheme

g['airline#extensions#tabline#enabled'] = false
