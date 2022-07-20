return function(opts)
  require'plugin-keymappings.telescope.buffers'()
  require'plugin-keymappings.telescope.commands'()
  require'plugin-keymappings.telescope.find_within_file'(opts)
  require'plugin-keymappings.telescope.git'()
  require'plugin-keymappings.telescope.navigation'(opts)
  require'plugin-keymappings.telescope.resume'()
end
