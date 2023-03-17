# frozen_string_literal: true

require_relative "elden_directory"
require_relative "kitty"
require_relative "paths"
require_relative "shell_command"
require_relative "vim_config_directory"
require_relative "with_vim"

module Elden
  class Shell
    include Elden::EldenDirectory
    include Elden::Kitty
    include Elden::Paths
    include Elden::ShellCommand
    include Elden::VimConfigDirectory
    include Elden::WithVim

    def initialize
      @windows = []
      super
    end

    def launch_dev(kitty_title: nil, sync_packer: false)
      launch_os_window(
        title: kitty_title,
        argument: with_vim(path: vim_dev_config_file_path!) do |opts|
          use_config(opts[:path])
          packer_sync if sync_packer
        end
      )
    end

    def update_plugins
      launch_window(
        argument: with_vim do
          packer_sync
          treesitter_update
        end,
        focus: false
      )
    end

    private

    attr_reader :windows
  end
end
