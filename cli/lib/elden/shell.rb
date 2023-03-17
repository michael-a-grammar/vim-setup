# frozen_string_literal: true

require          "securerandom"
require_relative "elden_directory"
require_relative "kitty"
require_relative "paths"
require_relative "shell_command"
require_relative "vim"
require_relative "vim_config_directory"

module Elden
  class Shell < Elden::Kitty
    include Elden::ShellCommand
    # include Elden::Kitty
    # include Elden::Vim
    include Elden::EldenDirectory
    include Elden::VimConfigDirectory

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

    def with_vim(opts = nil, &)
      with(Elden::Vim, opts, &)
    end

    private

    def with(const, opts = nil, &)
      instance    = const.new
      method_name = "anonymous_#{SecureRandom.uuid.gsub("-", "_")}"

      instance.define_singleton_method(method_name, &)

      result = if opts.nil?
                 instance.send(method_name)
               else
                 instance.send(method_name, opts)
               end

      instance.singleton_class.remove_method(method_name)

      result || instance.instance_variable_get("@arguments")
    end
  end
end
