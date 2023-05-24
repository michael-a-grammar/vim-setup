return {
  disabled_plugins = {
    ''
  },
  packer = {
    install_path                 = '/site/pack/packer/start/packer.nvim',
    install_path_relative        = true,
    relative_plugins_config_path = 'plugins.config',
    repo                         = 'https://github.com/wbthomason/packer.nvim',
  },
  windows = {
    enable = {
      select_buffer_upon_split = true,
    },
  },
}
