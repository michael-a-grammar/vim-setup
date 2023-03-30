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

    def launch_dev!(kitty_title: nil,
                    sync_packer: false,
                    update_treesitter: false)
      launch_tab(title: kitty_title,
                 argument: with_vim(path: vim_dev_config_file_path!) do |opts|
                             use_config(opts[:path])
                             packer_sync if sync_packer
                             treesitter_update if update_treesitter
                           end)
    end

    def update_plugins(sync_packer: true,
                       update_treesitter: true)
      launch_window(argument: with_vim do
                                packer_sync if sync_packer
                                treesitter_update if update_treesitter
                              end)
    end

    def sync!(purge_vim_config_directory: false,
              sync_packer: false,
              update_treesitter: false,
              launch_dev: false)
      vim_config_directory_purge! if purge_vim_config_directory

      elden_directory_sync!

      if launch_dev
        launch_dev!(sync_packer:, update_treesitter:)
      else
        update_plugins(sync_packer:, update_treesitter:)
      end
    end

    private

    attr_reader :windows
  end
end
