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
    def initialize(*args, opts: {})
      opts[:namespace].const_set(opts[:class_name], Class.new do
        include Args

        define_method :initialize, ShellCommand.create_initialize(opts)

        args.each { |arg| define_method arg[:name] || arg[:arg], ShellCommand.handle_arg(arg) }
      end)
    end

    def self.create_initialize(opts)
      proc do
        @args       = []
        @cmd        = opts[:cmd]        || ""
        @arg_prefix = opts[:arg_prefix] || ""
      end
    end

    def self.handle_arg(arg) = proc { |param = nil| add_args(arg, param) }

    module Args
      def args
        cmd    = "#{@cmd} " || ""
        joined = @args.collect { |arg| get_arg(arg) }.join(" ")

        "#{cmd}#{joined}"
      end

      private

      def add_args(arg, param = nil)
        arg = arg.dup if arg[:allow_multi]
        arg.store(:param, param)

        @args.append(arg)

        self
      end

      def get_arg(arg)
        prefix    = get_from_arg(arg, :arg_prefix, "")
        name      = arg[:arg]   || arg[:name]
        param     = arg[:param] || ""
        param_sep = get_from_arg(arg, :param_sep, " ")
        param_sur = get_from_arg(arg, :param_sur, "")

        "#{prefix}#{name}#{param_sep}#{param_sur}#{param}#{param_sur}"
      end

      def get_from_arg(arg, key, *defaults)
        arg[key] || instance_variable_get("@#{key}") || defaults.find { |d| !d.nil? && !d.empty? }
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
  {
    name: "config",
    arg_prefix: "-",
    arg: "u"
  },
  {
    name: "command",
    arg_prefix: "",
    arg: "+",
    param_sep: "",
    allow_multi: true
  },
  {
    name: "headless",
    arg_prefix: "--"
  },
  opts: {
    namespace: Elden,
    class_name: "NeoVimShellCommand",
    cmd: "nvim"
  }
)

class NeoVim
  def intialize(shell)
    @shell = shell
  end

  def config(config_path) = @shell.config(config_path)

  def command(cmd) = @shell.command(cmd)
end

@p = Elden::Paths.new
@c = Elden::NeoVimShellCommand.new

@c.config(@p.elden_path)
@c.command("PackerCompile")
@c.command("PackerSync")
