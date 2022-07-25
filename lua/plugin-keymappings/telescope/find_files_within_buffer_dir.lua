return function()
  local telescope  = require'telescope.builtin'
  local buffer_dir = require'telescope.utils'.buffer_dir
  local u          = require'milque.cartographer'.with.nx_leader_u

  local function find_within_buffer_dir(fn)
    return function()
      fn({ cwd = buffer_dir() })
    end
  end

  u()
  .use_f()
  .rhs
  .fn(find_within_buffer_dir(telescope.find_files))
  .exe()

  u()
  .use_g()
  .rhs
  .fn(find_within_buffer_dir(telescope.live_grep))
  .exe()

  u()
  .use_w()
  .rhs
  .fn(find_within_buffer_dir(telescope.grep_string))
  .exe()
end
