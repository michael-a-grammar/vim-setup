require './vim'

desc 'Install Plug plugins'

namespace :vim do
  task :install_plugins do
    commands = Vim.plug_install.call

    sh commands
  end
end
