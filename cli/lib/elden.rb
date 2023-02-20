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

    def env_path(name, *paths, default: "") = path(ENV[name] || default, paths)
    def exist?(path)                        = File.exist?(path) ? path : false
  end

  class ShellCommand # rubocop:todo Style/Documentation
    def initialize(*args, opts: {}) # rubocop:disable Metrics/MethodLength
      opts[:namespace].const_set("#{opts[:class_name]}ShellCommand", Class.new do
        include Args

        define_method :initialize do
          @args       = []
          @cmd        = opts[:cmd]        || ""
          @arg_prefix = opts[:arg_prefix] || ""
        end

        args.each do |arg|
          define_method arg[:name] || arg[:arg] do |param = nil|
            add_arg(arg, param)
          end
        end
      end)
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
        arg[key] || instance_variable_get("@#{key}") || defaults.find do |default|
          !default.nil? && !default.empty?
        end
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

class KittyLaunch # rubocop:todo Style/Documentation
  %w[window tab os_window].each do |type|
    define_method "as_#{type}" do |arg: "", title: nil|
      launch(type, title:, arg:)
    end
  end

  def as(type, title: nil, arg: "") # rubocop:disable Metrics/MethodLength
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

  def default_title = "elden-#{SecureRandom.uuid}"
end

class Kitty # rubocop:todo Style/Documentation
  def initialize
    @kitty_windows = []
  end

  def with(&)
    return unless block_given?

    kitty_title, kitty_cmd = instance_exec(&)

    @kitty_windows << kitty_title

    kitty_cmd
  end

  private

  def kitty_launch   = KittyLaunch.new
  def with_neovim(&) = NeoVim.new(Elden::Paths.new).with(&)
end

module WithKitty # rubocop:todo Style/Documentation
  def with_kitty(&)
    kitty.with(&)
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

  def with(&)
    instance_exec(&)
    cmd_with_args
  end

  def use_dev_config    = update(:config, @paths.nvim_dev_config_path)
  def treesitter_update = add_cmd("TSUpdateSync")
  def cmd_with_args     = @neovim.cmd_with_args

  private

  def update(method, param)
    @neovim.send(method, param)
    self
  end

  def add_cmd(cmd) = update(:cmd, cmd)
end

class Shell # rubocop:todo Style/Documentation
  include WithKitty

  def initialize(kitty)
    @kitty = kitty
  end

  def dev(kitty_title: nil, sync_packer: false)
    with_kitty do
      launch_os_window(
        title: kitty_title,
        arg: with_neovim do
          use_dev_config
          packer_sync if sync_packer
        end
      )
    end
  end

  def update_plugins
    with_kitty do
      launch_window(
        arg: with_neovim do
          packer_sync
          treesitter_update
        end
      )
    end
  end

  private

  attr_reader :kitty
end

module Elden
  class CLI < Thor # rubocop:todo Style/Documentation
    desc "dev", "Starts a development environment"
    def dev; end
  end
end

@paths  = Elden::Paths.new
@neovim = NeoVim.new(@paths)
@kitty  = Kitty.new
@shell  = Shell.new(@kitty)
