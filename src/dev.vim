lua << EOF
  local paths = require'elden.paths'

  runtimepath:append(paths.elden)
  runtimepath:remove(paths.vim_config)
  runtimepath:remove(paths.vim_after)

  require'elden.prelude'
EOF
