# frozen_string_literal: true

require          "thor"
require_relative "cli_attributes"
require_relative "shell"

module Elden
  class CLI < Thor
    extend Elden::CLIAttributes

    dev_command
    def dev
      elden_shell
        .dev!(kitty_title: options[:kitty_title],
              sync_packer: options[:sync_packer],
              update_treesitter: options[:update_treesitter])
        .run!
    end

    update_command
    def update
      elden_shell
        .update(sync_packer: true,
                update_treesitter: options[:update_treesitter])
        .run!
    end

    sync_command
    def sync
      elden_shell
        .sync!(purge_vim_config_directory: options[:purge_vim_config_directory],
               sync_packer: options[:sync_packer],
               update_treesitter: options[:update_treesitter],
               launch_dev: options[:launch_dev])
        .run!
    end

    private

    def elden_shell = Elden::Shell.new
  end
end
