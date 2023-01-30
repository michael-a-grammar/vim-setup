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

  class ShellCommand
    def initialize(namespace, class_name, *args, opts: {})
      namespace.const_set(class_name, Class.new do
        include Args

        define_method :initialize do
          @args       = []
          @cmd        = opts[:cmd]        || ""
          @arg_prefix = opts[:arg_prefix] || ""
        end

        args.each do |arg|
          define_method "add_#{arg[:name]}", ShellCommand.handle_arg(arg)
        end
      end)
    end

    def self.handle_arg(arg)
      if arg[:has_param]
        proc do |param|
          add_args(arg, param)
          self
        end
      else
        proc do
          add_args(arg)
          self
        end
      end
    end

    module Args
      def args
        @args.collect do |arg|
          cmd    = "#{@cmd} " || ""
          prefix = arg[:prefix] || @arg_prefix || ""
          name   = arg[:name]

          if arg[:has_param] && arg[:param]
            param_sep = arg[:param_sep] || @param_sep || " "
            param_sur = arg[:param_sur] || @param_sur || ""
            param     = arg[:param]     || ""

            "#{cmd}#{prefix}#{name}#{param_sep}#{param_sur}#{param}#{param_sur}"
          else
            "#{prefix}#{name}"
          end
        end
             .join(" ")
      end

      private

      def add_args(arg, param = nil)
        arg.store(:param, param)

        @args.append(arg)
      end
    end
  end

  class Vim
    VIM_COMMAND = "nvim"

    def initialize
      @paths    = Paths.new
      @commands = []
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

@a = Elden::ShellCommand.new(
  Elden,
  "NeoVim",
  { name: "headless" },
  { name: "config",  arg: "u", has_param: true },
  { name: "command", arg: "+", has_param: true },
  opts: { cmd: "nvim", arg_prefix: "-" }
)

@c = Elden::NeoVim.new

@c.add_u("awesome")
@c.add_.to_s
