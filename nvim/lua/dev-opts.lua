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

  packer = {
    install_path                 = '/site/pack/packer/start/packer.nvim',
    is_install_path_relative     = true,
    relative_plugins_config_path = 'plugins.config',
    repo                         = 'https://github.com/wbthomason/packer.nvim',
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
