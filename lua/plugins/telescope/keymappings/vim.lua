return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with'z'

  set(':', telescope.commands,      'Commands')
  set('h', telescope.help_tags,     'Help tags')
  set('k', telescope.keymaps,       'Keymaps')
  set('k', telescope.reloader,      'Lua modules')
  set('o', telescope.vim_options,   'Options')
  set('r', telescope.registers,     'Registers')
  set('s', telescope.spell_suggest, 'Spelling suggestions')
  set('t', telescope.colorscheme,   'Colourschemes')
end
