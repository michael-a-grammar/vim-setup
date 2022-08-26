return function()
  local buffer_dir = require'telescope.utils'.buffer_dir

  local finderscope =
    require'plugin-keymappings.telescope.find_files.finderscope'

  finderscope.set(
    function()
      return require'milque.cartographer'.nx_leader_with('u')
    end,
    finderscope.find_files_using({
      find_files_within_dir_fn = buffer_dir,
      desc_suffix              = 'within buffer directory'
  }))
end
