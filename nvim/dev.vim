lua << EOF
  vim.opt.runtimepath:remove(paths.config_path)
  vim.opt.runtimepath:remove(paths.config_path .. '/after')
  vim.opt.runtimepath:append(paths.dev_path)

  require'start'
EOF
