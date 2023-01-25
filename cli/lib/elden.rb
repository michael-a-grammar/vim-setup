# frozen_string_literal: true

require_relative "elden/version"
require "thor"

module Elden
  class Paths
    attr_reader :elden_path, :config_path

    def initialize
      @elden_path  = env_path("ELDEN_PATH")
      @config_path = env_path("XDG_CONFIG_HOME", "~/", ".config", "nvim")
    end

    private

    def env_path(name, default = "", *paths)
      joined_path =
        File.join(
          File.expand_path(
            ENV[name] || default
          ),
          paths
        )

      File.exist?(joined_path) ? joined_path : false
    end
  end

  module Kitty
    KITTY_COMMAND = "kitty @"

    class Launcher
      def initialize
        @paths = Paths.new
      end

      def launch(type, start)
        `#{KITTY_COMMAND} launch #{type_arg(type)} #{start}`
      end

      private

      def type_arg(type) = "--type='#{type.to_s.gsub("_", "-")}'"
    end
  end

  class ShellExecutable
    def initialize(namespace, class_name, *commands, prefix: "")
      namespace.const_set(class_name, Class.new do
        include Commands

        define_method :initialize do
          @commands = []
        end

        commands.each do |command|
          define_method "with_#{command[:name]}", ShellExecutable.handle_command(command)
        end
      end)
    end

    def self.handle_command(command)
      if command[:has_argument]
        proc do |argument|
          update_commands(command, argument)
        end
      else
        proc do
          update_commands(command)
        end
      end
    end

    module Commands
      def commands
        @commands
      end

      private

      def update_commands(command, argument = nil)
        @commands.append({ command => argument })
      end
    end
  end

  class Vim
    VIM_COMMAND = "nvim"

    def initialize
      @paths    = Paths.new
      @commands = {}
    end

    def config(config_file_path)
      update_commands(:u, config_file_path)
    end

    def headless
      update_commands(:headless)
    end

    private

    def update_commands(key, value: false)
      @commands.append({ key => value }) unless @commands.key?(key)
    end
  end

  class CLI < Thor
    desc "dev", "Starts a development environment"
    def dev
      Kitty::Launcher.new.launch(:os_window, "nvim")
    end
  end
end
