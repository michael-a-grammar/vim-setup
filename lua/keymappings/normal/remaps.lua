return function()
  local set = require'keymappings.helpers'.nx

  set(',,', ',', 'Previous match')

  set('0', 'g0', 'Beginning of line')

  set('^', 'g^', 'Start of line')
  set('H', 'g^', 'Start of line')

  set('$', 'g$', 'End of line')
  set('L', 'g$', 'End of line')

  set('-', 'ddp',     'Move line down')
  set('_', 'dd<up>P', 'Move line up')

  set('<a-left>', '<c-u>',  'Delete word backwards')
  set('<a-right>', '<c-d>', 'Delete word forwards')

  set('n', 'nzzzv', 'Next match and centre')
  set('N', 'Nzzzv', 'Previous match and centre')
end
