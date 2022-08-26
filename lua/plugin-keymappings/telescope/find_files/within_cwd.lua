return function()
  local find_using
    = require'plugin-keymappings.telescope.find_files.find_using'

  find_using.set('s', find_using.within_dir(nil, {
    desc_suffix = '(Within current working directory)'
  }))
end
