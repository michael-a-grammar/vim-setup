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

    module Args # rubocop:todo Style/Documentation
      def cmd_with_args
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
    name: "title"
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

class Kitty # rubocop:todo Style/Documentation
  %w[window tab os_window].each do |type|
    define_method "launch_#{type}" do |arg: "", title: nil|
      launch(type, title:, arg:)
    end
  end

  def launch(type, title: nil, arg: "") # rubocop:disable Metrics/MethodLength
    title ||= default_title

    [title, Elden::KittyShellCommand.new
                                    .cmd("launch")
                                    .title(title)
                                    .type(
                                      type
                                        .to_s
                                        .gsub("_", "-")
                                    )
                                    .arg(arg)
                                    .cmd_with_args]
  end

  private

  def default_title
    "elden-#{SecureRandom.uuid}"
  end
end

class NeoVim # rubocop:todo Style/Documentation
  def initialize(paths)
    @paths  = paths
    @neovim = Elden::NeoVimShellCommand.new
  end

  %w[clean compile sync].each do |cmd|
    define_method "packer_#{cmd}" do
      add_cmd("Packer#{cmd.capitalize}")
    end
  end

  def self.create_if
    proc do |condition, &block|
      instance_exec_if(condition, block)
    end
  end

  def self.create_with
    proc do |&block|
      instance_exec_if(true, block)
      cmd_with_args
    end
  end

  define_method :if,   NeoVim.create_if
  define_method :with, NeoVim.create_with

  def use_dev_config
    update(:config, @paths.nvim_dev_config_path)
  end

  def treesitter_update
    add_cmd("TSUpdateSync")
  end

  def cmd_with_args
    @neovim.cmd_with_args
  end

  private

  def update(method, param)
    @neovim.send(method, param)
    self
  end

  def add_cmd(cmd)
    update(:cmd, cmd)
  end

  def instance_exec_if(condition, block)
    instance_exec(&block) if condition
    self
  end
end

class Shell # rubocop:todo Style/Documentation
  def initialize(paths)
    @paths         = paths
    @kitty_windows = []
  end

  def dev(kitty_title: nil, sync_packer: false)
    with do
      kitty.launch_os_window(
        title: kitty_title,
        arg: neovim.with do
          use_dev_config
          packer_sync if sync_packer
        end
      )
    end
  end

  def update_plugins
    with do
      kitty.launch_window(
        arg: neovim.with do
          packer_sync
          treesitter_update
        end
      )
    end
  end

  def with(&)
    return kitty unless block_given?

    kitty_title, kitty_window = instance_exec(&)

    @kitty_windows << kitty_title

    kitty_window
  end

  def kitty  = Kitty.new
  def neovim = NeoVim.new(@paths)
end

module Elden
  class CLI < Thor # rubocop:todo Style/Documentation
    desc "dev", "Starts a development environment"
    def dev; end
  end
end
