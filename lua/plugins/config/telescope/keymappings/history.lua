return function()
  local telescope = require'telescope.builtin'
  local set       = require'milque.cartographer'.nx_leader_with'h'

  set('\'', telescope.resume,          'Resume picker')

  set(',', telescope.quickfixhistory, 'Quickfix')
  set('.', telescope.pickers,         'Telescope pickers')
  set(':', telescope.command_history, 'Commands')
  set(';', telescope.search_history,  'Searches')
  set('T', telescope.resume,          'Resume last Telescope picker')
end
