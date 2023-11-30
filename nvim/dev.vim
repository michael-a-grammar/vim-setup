lua << EOF
  local paths = require'api.paths'

  runtimepath:append(paths.elden)
  runtimepath:remove(paths.vim_config)
  runtimepath:remove(paths.vim_after)

  require'prelude'
EOF
