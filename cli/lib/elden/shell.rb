# frozen_string_literal: true

require_relative "kitty"
require_relative "neo_vim"
require_relative "paths"
require_relative "shell_command"

module Elden
  class Shell < Elden::Kitty # rubocop:todo Style/Documentation
    extend Elden::ShellCommand

    def initialize
      @paths = Elden::Paths.new
      super
    end

    def launch_dev(kitty_title: nil, sync_packer: false)
      launch_os_window(
        title: kitty_title,
        argument: with_neovim(path: @paths.nvim_dev_config_path) do |opts|
          use_config(opts[:path])
          packer_sync if sync_packer
        end
      )
    end

    def update_plugins
      launch_window(
        argument: with_neovim do
          packer_sync
          treesitter_update
        end,
        focus: false
      )
    end

    def with_neovim(opts = nil, &)
      neovim = Elden::NeoVim.new
      neovim.instance_exec(opts, &)
      neovim.arguments
    end
  end
end
