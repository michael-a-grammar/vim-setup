require './vim'

namespace :vim do
  desc 'Install plugins'
  task :install_plugins do
    Vim.plug_install.run
  end

  desc 'Update plugins'
  task :update_plugins do
    Vim.plug_update.run
  end

  desc 'Clean plugins'
  task :clean_plugins do
    Vim.plug_clean.run
  end

  desc 'Update Plug'
  task :upgrade_plug do
    Vim.plug_upgrade.run
  end
end
