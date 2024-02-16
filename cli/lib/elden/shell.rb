# frozen_string_literal: true

require_relative "kitty"
require_relative "path_operations"
require_relative "shell_command"
require_relative "with_vim"

module Elden
  class Shell
    include Elden::Kitty
    include Elden::Paths
    include Elden::PathOperations
    include Elden::ShellCommand
    include Elden::WithVim

    def initialize
      @windows = []
      super
    end

    shell_command
    def dev!(kitty_title: nil,
             compile_packer: false,
             sync_packer: false,
             update_treesitter: false)
      launch_tab(title: kitty_title,
                 argument: with_vim(path: elden_dev_config_file_path!) do |opts|
                             use_config(opts[:path])
                             packer_compile if compile_packer && !sync_packer
                             packer_sync if sync_packer && !compile_packer
                             treesitter_update if update_treesitter
                           end)
    end

    shell_command
    def update(compile_packer: false,
               sync_packer: true,
               update_treesitter: true)
      launch_window(argument: with_vim do
                                packer_compile if compile_packer && !sync_packer
                                packer_sync if sync_packer && !compile_packer
                                treesitter_update if update_treesitter
                              end)
    end

    shell_command
    def sync!(purge_vim_lua_directory: false,
              compile_packer: false,
              sync_packer: false,
              update_treesitter: false,
              launch_dev: false)
      vim_lua_directory_purge! if purge_vim_lua_directory

      elden_directory_sync!

      if launch_dev
        launch_dev!(compile_packer:, sync_packer:, update_treesitter:)
      else
        update_plugins(compile_packer:, sync_packer:, update_treesitter:)
      end
    end

    private

    attr_reader :windows
  end
end
