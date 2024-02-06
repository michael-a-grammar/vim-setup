# frozen_string_literal: true

module Elden
  module CLIAttributes
    [
      {
        name: :kitty_title,
        alias: "k",
        type: :string,
        desc: "Sets the title of the newly created Kitty window"
      },
      {
        name: :compile_packer,
        alias: "c",
        desc: "Compile packer"
      },
      {
        name: :sync_packer,
        alias: "s",
        desc: "Sync packer"
      },
      {
        name: :update_treesitter,
        alias: "t",
        desc: "Updates installed Treesitter parsers"
      },
      {
        name: :purge_vim_config_directory,
        alias: "p",
        desc: "Purge the Vim config directory before Packer compile or sync"
      },
      {
        name: :launch_dev,
        alias: "l",
        desc: "Starts a development environment"
      }
    ].each do |option_info|
      define_method("#{option_info[:name]}_option") do
        if option_info.key?(:type) && option_info[:type] == :string
          option(option_info[:name],
                 aliases: option_info[:alias],
                 desc: option_info[:desc])
        else
          boolean_option(option_info[:name],
                         aliases: option_info[:alias],
                         desc: option_info[:desc])
        end
      end
    end

    [
      {
        name: :dev,
        desc: "Starts a development environment"
      },
      {
        name: :update,
        desc: "Updates plugins"
      },
      {
        name: :sync,
        desc: "Sync development with the local environment"
      }
    ].each do |description_info|
      define_method("#{description_info[:name]}_description") do
        desc(description_info[:name], description_info[:desc])
      end
    end

    [
      {
        name: :dev,
        attributes: %i[
          dev_description
          kitty_title_option
          compile_packer_option
          sync_packer_option
          update_treesitter_option
        ]
      },
      {
        name: :update,
        attributes: %i[
          update_description
          update_treesitter_option
        ]
      },
      {
        name: :sync,
        attributes: %i[
          sync_description
          purge_vim_config_directory_option
          compile_packer_option
          sync_packer_option
          update_treesitter_option
          launch_dev_option
        ]
      }
    ].each do |command_info|
      define_method("#{command_info[:name]}_command") do
        command_info[:attributes].each do |attribute|
          send(attribute)
        end
      end
    end

    private

    def boolean_option(name, aliases:, desc:)
      option(name, aliases:, type: :boolean, desc:)
    end
  end
end
