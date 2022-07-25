return function(find_within)
  local telescope    = require'telescope.builtin'
  local buffer_dir   = require'telescope.utils'.buffer_dir
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local u            = require'milque.cartographer'.with.nx_leader_u

  local find_within_buffer_dir = find_within(buffer_dir)

  u()
  .use_d()
  .rhs
  .fn(find_within_buffer_dir(file_browser, 'path'))
  .exe()

  u()
  .use_f()
  .rhs
  .fn(find_within_buffer_dir(telescope.find_files))
  .exe()

  u()
  .use_s()
  .rhs
  .fn(find_within_buffer_dir(telescope.live_grep))
  .exe()

  u()
  .use_w()
  .rhs
  .fn(find_within_buffer_dir(telescope.grep_string))
  .exe()
end
