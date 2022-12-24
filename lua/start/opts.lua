if elden.opts == nil then
  local opts = {
    colorscheme      = 'iceberg',
    disabled_plugins = {
      'cmp'
    },
    windows = {
      enable = {
        select_buffer_upon_split = true
      }
    }
  }

  local local_opts = require'local-opts'

  local extended_opts = vim.tbl_deep_extend('force', opts, local_opts)

  elden.opts = extended_opts
end

return elden.opts
