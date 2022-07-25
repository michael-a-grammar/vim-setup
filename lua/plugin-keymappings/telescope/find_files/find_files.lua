return function()
  local telescope    = require'telescope.builtin'
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local s            = require'milque.cartographer'.with.nx_leader_s

  s()
  .use_c()
  .rhs
  .fn(telescope.quickfix)
  .exe()

  s()
  .use_d()
  .rhs
  .fn(file_browser)
  .exe()

  s()
  .use_f()
  .rhs
  .fn(telescope.find_files)
  .exe()

  s()
  .use_g()
  .rhs
  .fn(telescope.git_files)
  .exe()

  s()
  .use_l()
  .rhs
  .fn(telescope.loclist)
  .exe()

  s()
  .use_m()
  .rhs
  .fn(telescope.marks)
  .exe()

  s()
  .use_p()
  .rhs
  .fn(telescope.jumplist)
  .exe()

  s()
  .use_r()
  .rhs
  .fn(telescope.oldfiles)
  .exe()

  s()
  .use_s()
  .rhs
  .fn(telescope.live_grep)
  .exe()

  s()
  .use_w()
  .rhs
  .fn(telescope.grep_string)
  .exe()
end
