return function()
  local buffer_dir = require'telescope.utils'.buffer_dir

  local finderscope =
    require'plugin-keymappings.telescope.find_files.finderscope'

  finderscope.set(
    function()
      return require'milque.cartographer'.nx_local_leader_with('s')
    end,
    finderscope.find_files_using({
      file_types  = 'elixir',
      desc_suffix = 'within current working directory'
  }))

  finderscope.set(
    function()
      return require'milque.cartographer'.nx_local_leader_with('u')
    end,
    finderscope.find_files_using({
      find_files_within_dir_fn = buffer_dir,
      file_types               = 'elixir',
      desc_suffix              = 'within buffer directory'
  }))
end

