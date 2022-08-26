return function()
  local finderscope =
    require'plugin-keymappings.telescope.find_files.finderscope'

  finderscope.set(
    function()
      return require'milque.cartographer'.nx_leader_with('s')
    end,
    finderscope.find_files_using({
      desc_suffix = 'within current working directory'
  }))
end
