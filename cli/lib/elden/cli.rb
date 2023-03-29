# frozen_string_literal: true

require          "thor"
require_relative "shell"

Elden::ShellCommand::ENABLED = true

module Elden
  class CLI < Thor
    desc "dev", "Starts a development environment"
    option :kitty_title,
           aliases: "k",
           desc: "Sets the title of the newly created Kitty window"
    option :sync_packer,
           aliases: "s",
           type: :boolean,
           desc: "Updates and compiles installed Vim plugins"
    option :update_treesitter,
           aliases: "t",
           type: :boolean,
           desc: "Updates installed Treesitter parsers"
    def dev
      elden_shell
        .launch_dev!(
          kitty_title: options[:kitty_title],
          sync_packer: options[:sync_packer],
          update_treesitter: options[:update_treesitter]
        ).run!
    end

    desc "update", "Updates plugins"
    option :update_treesitter,
           aliases: "t",
           type: :boolean,
           desc: "Updates installed Treesitter parsers"
    def update
      elden_shell.update_plugins(
        sync_packer: true,
        update_treesitter: options[:update_treesitter]
      ).run!
    end

    desc "sync", "Sync development with the local environment"
    option :purge_vim_config_directory,
           aliases: "p",
           type: :boolean,
           desc: "Purge the Vim config directory before sync"
    option :sync_packer,
           aliases: "s",
           type: :boolean,
           desc: "Updates and compiles installed Vim plugins"
    option :update_treesitter,
           aliases: "t",
           type: :boolean,
           desc: "Updates installed Treesitter parsers"
    option :launch_dev,
           aliases: "l",
           type: :boolean,
           desc: "Starts a development environment"
    def sync
      elden_shell.sync!(
        purge_vim_config_directory: options[:purge_vim_config_directory],
        sync_packer: options[:sync_packer],
        update_treesitter: options[:update_treesitter],
        launch_dev: options[:launch_dev]
      ).run!
    end

    private

    def elden_shell = Elden::Shell.new
  end
end
