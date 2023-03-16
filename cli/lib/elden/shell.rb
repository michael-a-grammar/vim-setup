# frozen_string_literal: true

require_relative "kitty"
require_relative "paths"
require_relative "shell_command"
require_relative "vim"

module Elden
  class Shell < Elden::Kitty # rubocop:todo Style/Documentation
    include Elden::ShellCommand

    def launch_dev(kitty_title: nil, sync_packer: false)
      launch_os_window(
        title: kitty_title,
        argument: with_vim(path: Elden::Paths.vim_dev_config_file_path) do |opts|
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

    def clean; end

    def deploy; end

    def with_vim(opts = nil, &)
      vim = Elden::Vim.new
      vim.instance_exec(opts, &)
      vim.arguments
    end
  end
end
