# frozen_string_literal: true

require_relative "elden_directory"
require_relative "kitty"
require_relative "paths"
require_relative "shell_command"
require_relative "vim"
require_relative "vim_config_directory"

module Elden
  class Shell < Elden::Kitty
    include Elden::ShellCommand

    def launch_dev(kitty_title: nil, sync_packer: false)
      launch_os_window(
        title: kitty_title,
        argument: with_vim(path: Elden::Paths.vim_dev_config_file_path!) do |opts|
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

    def sync
    end

    def purge; end

    def with(const, opts = nil, &)
      instance = const.new
      instance.instance_exec(opts, &)
      instance
    end

    def with_vim(opts = nil, &)
      with(Elden::Vim, opts, &)
      vim.arguments
    end

    def with_elden_directory(opts = nil, &)
      with(Elden::EldenDirectory, opts, &)

      # ??
    end
  end
end
