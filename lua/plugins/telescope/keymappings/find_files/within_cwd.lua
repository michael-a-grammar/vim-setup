return function()
  local telescope    = require'telescope.builtin'
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local set          = require'milque.cartographer'.nx_leader_with('s')

  set('d', file_browser,          'File browser')
  set('f', telescope.find_files,  'Find files')
  set('s', telescope.live_grep,   'Grep')
  set('w', telescope.grep_string, 'Grep current word')

  set(
    'r',
    function()
      telescope.oldfiles{
        only_cwd = true
      }
    end,
    'Recent files (cwd)')
end
