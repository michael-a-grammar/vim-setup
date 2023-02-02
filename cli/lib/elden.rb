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

  class ShellCommand
    def initialize(*args, opts: {})
      opts[:namespace].const_set("#{opts[:class_name]}ShellCommand", Class.new do
        include Args

        define_method :initialize, ShellCommand.create_initialize(opts)

        args.each do |arg|
          define_method arg[:name] || arg[:arg], ShellCommand.handle_arg(arg)
        end
      end)
    end

    def self.create_initialize(opts)
      proc do
        @args       = []
        @cmd        = opts[:cmd]        || ""
        @arg_prefix = opts[:arg_prefix] || ""
      end
    end

    def self.handle_arg(arg)
      proc do |param = nil|
        add_args(arg, param)
      end
    end

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

  class CLI < Thor
    desc "dev", "Starts a development environment"
    def dev
      2
    end
  end
end

@p = Elden::Paths.new

@c = Elden::ShellCommand.new(
  {
    name: "config",
    arg_prefix: "-",
    arg: "u"
  },
  {
    name: "cmd",
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
    class_name: "NeoVim",
    cmd: "nvim"
  }
)

@d = Elden::ShellCommand.new(
  {
    name: "type"
  },
  {
    name: "cmd",
    arg_prefix: "",
    arg: "",
    param_sep: ""
  },
  opts: {
    namespace: Elden,
    class_name: "KittyLaunch",
    cmd: "kitty @ launch",
    arg_prefix: "--",
    param_sep: "="
  }
)

@n = Elden::NeoVimShellCommand.new
                              .config(@p.elden_path)
                              .cmd("PackerCompile")
                              .cmd("PackerSync")

@k = Elden::KittyLaunchShellCommand.new
                                   .type("os-window")
                                   .cmd(@n.args)

`#{@k.args}`
