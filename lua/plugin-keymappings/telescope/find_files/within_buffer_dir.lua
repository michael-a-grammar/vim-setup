return function()
  local telescope    = require'telescope.builtin'
  local buffer_dir   = require'telescope.utils'.buffer_dir
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local set          = require'keymappings.helpers'.nx_leader_with('u')

  local find_within
    = require'plugin-keymappings.telescope.find_files.find_within'

  local find_within_buffer_dir = find_within(buffer_dir)

  set('d', find_within_buffer_dir(file_browser, 'path'),  'File browser')
  set('f', find_within_buffer_dir(telescope.find_files),  'Find files')
  set('s', find_within_buffer_dir(telescope.live_grep),   'Grep')
  set('u', find_within_buffer_dir(telescope.grep_string), 'Grep current word')
end
