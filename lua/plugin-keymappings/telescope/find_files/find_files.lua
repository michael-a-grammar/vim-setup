return function()
  local telescope    = require'telescope.builtin'
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local set          = require'keymappings.helpers'.nx_leader_with('s')

  set('c', telescope.quickfix,    'quickfix')
  set('d', file_browser,          'File browser')
  set('f', telescope.find_files,  'Fuzzy find')
  set('g', telescope.git_files,   'git')
  set('l', telescope.loclist,     'loclist')
  set('m', telescope.marks,       'Marks')
  set('p', telescope.jumplist,    'Jumps')
  set('r', telescope.oldfiles,    'Recent files')
  set('s', telescope.live_grep,   'Grep')
  set('w', telescope.grep_string, 'Grep current word')
end
