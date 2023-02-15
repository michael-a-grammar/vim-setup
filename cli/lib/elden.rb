# frozen_string_literal: true

require_relative "elden/version"
require "securerandom"
require "thor"

module Elden
  class Paths # rubocop:todo Style/Documentation
    attr_reader :elden_path, :config_path, :nvim_dev_config_path

    def initialize
      @elden_path           = env_path("ELDEN_PATH")
      @config_path          = env_path("XDG_CONFIG_HOME", ".config", "nvim", default: "~/")
      @nvim_dev_config_path = path(@elden_path, "dev.vim")
    end

    private

    def path(path, *paths)
      joined_path =
        File.join(
          File.expand_path(
            path
          ),
          paths
        )

      exist?(joined_path)
    end

    def env_path(name, *paths, default: "")
      path(
        ENV[name] || default,
        paths
      )
    end

    def exist?(path)
      File.exist?(path) ? path : false
    end
  end

  class ShellCommand # rubocop:todo Style/Documentation
    def initialize(*args, opts: {})
      opts[:namespace].const_set("#{opts[:class_name]}ShellCommand", Class.new do
        include Args

        define_method :initialize, ShellCommand.create_initialize(opts)

        args.each do |arg|
          define_method arg[:name] || arg[:arg], ShellCommand.create_add_arg(arg)
        end

        define_method :if, ShellCommand.create_if
      end)
    end

    def self.create_initialize(opts)
      proc do
        @args       = []
        @cmd        = opts[:cmd]        || ""
        @arg_prefix = opts[:arg_prefix] || ""
      end
    end

    def self.create_add_arg(arg)
      proc do |param = nil|
        add_arg(arg, param)
      end
    end

    def self.create_if
      proc do |condition, block|
        instance_exec(&block) if condition
        self
      end
    end

    module Args # rubocop:todo Style/Documentation
      def args
        cmd    = "#{@cmd} " || ""
        joined = @args.collect { |arg| get_arg(arg) }.join(" ")

        "#{cmd}#{joined}"
      end

      private

      def add_arg(arg, param = nil)
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
        arg[key] || instance_variable_get("@#{key}") || defaults.find { |default| !default.nil? && !default.empty? }
      end
    end
  end

  class CLI < Thor # rubocop:todo Style/Documentation
    desc "dev", "Starts a development environment"
    def dev
      2
    end
  end
end

Elden::ShellCommand.new(
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

Elden::ShellCommand.new(
  {
    name: "cmd",
    arg_prefix: "",
    arg: "",
    param_sep: ""
  },
  {
    name: "type"
  },
  {
    name: "name"
  },
  {
    name: "arg",
    arg_prefix: "",
    arg: "",
    param_sep: ""
  },
  opts: {
    namespace: Elden,
    class_name: "Kitty",
    cmd: "kitty @",
    arg_prefix: "--",
    param_sep: "="
  }
)

class KittyLaunch # rubocop:todo Style/Documentation
  def initialize(name = "elden-#{SecureRandom.uuid}")
    @name  = name
    @kitty = Elden::KittyShellCommand.new
                                     .cmd("launch")
                                     .name(@name)
  end

  def launch(type, arg)
    @kitty
      .type(type)
      .arg(arg)
  end
end

class NeoVim # rubocop:todo Style/Documentation
  def initialize(paths)
    @paths  = paths
    @neovim = Elden::NeoVimShellCommand.new
  end

  def use_dev_config
    update(:config, @paths.nvim_dev_config_path)
  end

  def packer_clean
    add_cmd("PackerClean")
  end

  def packer_compile
    add_cmd("PackerCompile")
  end

  def packer_sync
    add_cmd("PackerSync")
  end

  def treesitter_update
    add_cmd("TSUpdate")
  end

  private

  def update(method, param)
    @neovim.send(method, param)
  end

  def add_cmd(cmd)
    update(:cmd, cmd)
  end
end

class DevEnvironment # rubocop:todo Style/Documentation
end
