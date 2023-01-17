return function()
  local local_opts = require'local-opts'
  local M          = {}

  local global_opts = {
    colorscheme      = 'iceberg',
    disabled_plugins = {
      'cmp'
    },
    packer = {
      install_path                 = '/site/pack/packer/start/packer.nvim',
      install_path_relative        = true,
      relative_plugins_config_path = 'plugins.config',
      repo                         = 'https://github.com/wbthomason/packer.nvim'
    },
    windows = {
      enable = {
        select_buffer_upon_split = true
      }
    }
  }

  local extended_opts = vim.tbl_deep_extend('force', global_opts, local_opts)

  M.global_opts   = global_opts
  M.local_opts    = local_opts
  M.extended_opts = extended_opts

  return M
end
