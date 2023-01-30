set runtimepath-=~/.config/nvim
set runtimepath+=~/dev/milque/vim-setup/nvim

lua << EOF
  local config_path =
    (os.getenv('XDG_CONFIG_PATH') or '~/.config') .. '/nvim/

  local dev_path    = os.getenv('ELDEN_PATH')

  vim.opt.runtimepath:remove(config_path)
  vim.opt.runtimepath:append(dev_path)

  require('dev')
EOF
