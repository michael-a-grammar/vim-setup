return function()
  local telescope = require'telescope.builtin'
  local set       = require'keymappings.helpers'.nx_leader

  set(',', telescope.quickfixhistory, 'quickfix')
  set('.', telescope.pickers,         'Telescope pickers')
  set(':', telescope.command_history, 'Commands')
  set(';', telescope.search_history,  'Searches')
  set('T', telescope.resume,          'Resume last Telescope picker')
end
