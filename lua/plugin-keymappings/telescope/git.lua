return function()
  local telescope = require'telescope.builtin'
  local g         = require'milque.cartographer'.with.nx_leader_g

  g()
  .use_C()
  .rhs
  .fn(telescope.git_commits)
  .exe()

  g()
  .use_b()
  .rhs
  .fn(telescope.git_branches)
  .exe()

  g()
  .use_c()
  .rhs
  .fn(telescope.git_bcommits)
  .exe()

  g()
  .use_f()
  .rhs
  .fn(telescope.git_files)
  .exe()

  g()
  .use_s()
  .rhs
  .fn(telescope.git_status)
  .exe()
end
