# frozen_string_literal: true

module Elden
  module CLIAttributes
    def dev_description    = desc("dev", "Starts a development environment")
    def update_description = desc("update", "Updates plugins")
    def sync_description   = desc("sync", "Sync development with the local environment")

    [
      {
        name: :kitty_title,
        alias: "k",
        type: :string,
        desc: "Sets the title of the newly created Kitty window"
      },
      {
        name: :sync_packer,
        alias: "s",
        desc: "Sets the title of the newly created Kitty window"
      },
      {
        name: :update_treesitter,
        alias: "t",
        desc: "Updates installed Treesitter parsers"
      },
      {
        name: :purge_vim_config_directory,
        alias: "p",
        desc: "Purge the Vim config directory before sync"
      },
      {
        name: :launch_dev,
        alias: "l",
        desc: "Starts a development environment"
      }
    ].each do |option_info|
      define_method("#{option_info.name}_option") do
        if option_info.key?(:type) && option_info.type == :string
          option(option_info.name,
                 aliases: option_info.alias,
                 desc: option_info.desc)
        else
          boolean_option(option_info.name,
                         aliases: option_info.alias,
                         desc: option_info.desc)
        end
      end
    end

    [
      {
        name: "dev",
        desc: "Starts a development environment"
      },
      {
        name: "update",
        desc: "Updates plugins"
      },
      {
        name: "sync",
        desc: "Sync development with the local environment"
      }
    ].each do |description_info|
      define_method("#{description_info.name}_description") do
        desc(description_info.name, description_info.desc)
      end
    end
    
    [
      {
      }
    ].each do |command_info|
      define_method("#{command_info.name}_command") do
        command_info.attributes.each do |attribute|
          send(attribute)
        end
      end
    end
    
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
