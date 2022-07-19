return function(opts)
  require'plugin-keymappings.telescope.commands'()
  require'plugin-keymappings.telescope.find_within_file'(opts)
  require'plugin-keymappings.telescope.git'()
end
