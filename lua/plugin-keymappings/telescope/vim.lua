return function()
  local telescope = require'telescope.builtin'
  local z         = require'milque.cartographer'.with.nx_leader_z

  z()
  .use(':')
  .rhs
  .fn(telescope.commands)
  .exe()

  z()
  .use('h')
  .rhs
  .fn(telescope.help_tags)
  .exe()

  z()
  .use('k')
  .rhs
  .fn(telescope.keymaps)
  .exe()

  z()
  .use('o')
  .rhs
  .fn(telescope.vim_options)
  .exe()

  z()
  .use('r')
  .rhs
  .fn(telescope.registers)
  .exe()

  z()
  .use('s')
  .rhs
  .fn(telescope.spell_suggest)
  .exe()

  z()
  .use('t')
  .rhs
  .fn(telescope.colorscheme)
  .exe()
end
