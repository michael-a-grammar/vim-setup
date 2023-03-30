# frozen_string_literal: true

module Elden
  module CLIAttributes
    def dev_description    = desc("dev", "Starts a development environment")
    def update_description = desc("update", "Updates plugins")
    def sync_description   = desc("sync", "Sync development with the local environment")

    def kitty_title_option
      option(:kitty_title,
             aliases: "k",
             desc: "Sets the title of the newly created Kitty window")
    end

    def sync_packer_option
      boolean_option(:sync_packer,
                     aliases: "s",
                     desc: "Updates and compiles installed Vim plugins")
    end

    def update_treesitter_option
      boolean_option(:update_treesitter,
                     aliases: "t",
                     desc: "Updates installed Treesitter parsers")
    end

    def purge_vim_config_directory_option
      boolean_option(:purge_vim_config_directory,
                     aliases: "p",
                     desc: "Purge the Vim config directory before sync")
    end

    def launch_dev_option
      boolean_option(:launch_dev,
                     aliases: "l",
                     desc: "Starts a development environment")
    end

    private

    def boolean_option(name, aliases:, desc:)
      option(name, aliases:, type: :boolean, desc:)
    end
  end
end
