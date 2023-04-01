lua << EOF
  local getenv      = os.getenv
  local normalize   = vim.fs.normalize
  local runtimepath = vim.opt.runtimepath

  local get_path = function(env_varname, default)
    local path = getenv(env_varname) or default

    return normalize(path)
  end

  local elden_path      = get_path('ELDEN_PATH')
  local vim_config_path = get_path('XDG_CONFIG_PATH', '~/.config') .. '/nvim'

  runtimepath:append(elden_path)
  runtimepath:remove(vim_config_path)
  runtimepath:remove(vim_config_path .. '/after')

  require'start'({
    is_dev = true
  })
EOF
