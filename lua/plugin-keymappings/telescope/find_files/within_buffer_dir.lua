return function()
  local telescope  = require'telescope.builtin'
  local buffer_dir = require'telescope.utils'.buffer_dir
  local set        = require'milque.cartographer'.nx_leader_with('u')

  local find_using
    = require'plugin-keymappings.telescope.find_files.find_using'

  local find_within_buffer_dir = find_using.within_dir(buffer_dir)

  set('d', find_within_buffer_dir(file_browser, 'path'),  'File browser')
  set('f', find_within_buffer_dir(telescope.find_files),  'Find files')
  set('s', find_within_buffer_dir(telescope.live_grep),   'Grep')
  set('w', find_within_buffer_dir(telescope.grep_string), 'Grep current word')
end
