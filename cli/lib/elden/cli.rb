# frozen_string_literal: true

require          "thor"
require_relative "cli_attributes"
require_relative "shell"

Elden::ShellCommand::ENABLED = true

module Elden
  class CLI < Thor
    extend Elden::CLIAttributes

    dev_description
    kitty_title_option
    sync_packer_option
    update_treesitter_option
    def dev
      elden_shell
        .launch_dev!(kitty_title: options[:kitty_title],
                     sync_packer: options[:sync_packer],
                     update_treesitter: options[:update_treesitter])
        .run!
    end

    update_description
    update_treesitter_option
    def update
      elden_shell
        .update_plugins(sync_packer: true,
                        update_treesitter: options[:update_treesitter])
        .run!
    end

    sync_description
    purge_vim_config_directory_option
    sync_packer_option
    update_treesitter_option
    launch_dev_option
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
