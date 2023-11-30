lua << EOF
  local paths = require'api.paths'

  runtimepath:append(paths.elden_path)
  runtimepath:remove(paths.vim_config_path)
  runtimepath:remove(paths.vim_after_path)

  require'prelude'()
EOF
