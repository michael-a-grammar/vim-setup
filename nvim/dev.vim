lua << EOF
  local getenv    = os.getenv
  local normalize = vim.fs.normalize

  local get_path = function(varname, default)
    local path = getenv(varname) or default

    return normalize(path)
  end

  local elden_path      = get_path('ELDEN_PATH')
  local vim_config_path = get_path('XDG_CONFIG_PATH', '~/.config')

  vim.opt.runtimepath:append(elden_path)
  vim.opt.runtimepath:remove(vim_config_path)
  vim.opt.runtimepath:remove(vim_config_path .. '/after')

  require'start'({
    is_dev = true
  })
EOF
