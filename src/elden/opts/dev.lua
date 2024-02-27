return {
  disabled_plugins = {
    '',
  },

  icons = {
    legends = {
      buffer                    = '',
      current_working_directory = '',
      file_type                 = '',
      force                     = '',
    },

    keys = {
      space     = '',
      backspace = '󰁮',
      tab       = '󰌒',
      down      = '',
      left      = '',
      up        = '',
      right     = '',
    },
  },

  lazy = {
    install_path                 = '/lazy/lazy.nvim',
    is_install_path_relative     = true,
    relative_plugins_config_path = 'elden.plugins',
    repo                         = 'https://github.com/folke/lazy.nvim.git',
  },

  plugins = {
    which_key = {
      alignment = "left",
    },
  },

  windows = {
    enable = {
      select_buffer_upon_split = true,
    },
  },
}
