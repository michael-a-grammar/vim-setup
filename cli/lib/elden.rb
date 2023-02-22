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
    def initialize(*args, opts: {}) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      opts[:namespace].const_set("#{opts[:class_name]}ShellCommand", Class.new do
        include Args

        define_method :initialize do
          @args       = []
          @cmd        = opts[:cmd]        || ""
          @arg_prefix = opts[:arg_prefix] || ""
        end

        def if(condition, &)     = instance_exec_if(condition, &)
        def unless(condition, &) = instance_exec_if(!condition, &)

        def instance_exec_if(condition, &)
          instance_exec(&) if condition
          self
        end

        args.each do |arg|
          name = (arg[:name] || arg[:arg]).to_s.gsub("-", "_")

          define_method name do |param = nil|
            add_arg(arg, param)
          end
        end
      end)
    end

    module Args # rubocop:todo Style/Documentation
      def cmd_with_args = "#{@cmd} #{@args.collect { |arg| get_arg(arg) }.join(" ")}"

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
        param_sep = get_from_arg(arg, :param_sep, param.empty? ? "" : " ")
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
    name: "title"
  },
  {
    name: "type"
  },
  {
    name: "keep-focus"
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
  def initialize = @windows = []

  %w[window tab os_window overlay overlay_main background].each do |type|
    define_method "launch_#{type}" do |arg: "", title: nil, focus: true|
      launch(type, title:, arg:, focus:)
    end
  end

  def launch(type, arg: "", title: nil, focus: true) # rubocop:disable Metrics/MethodLength
    title ||= default_title

    cmd =
      Elden::KittyShellCommand.new
                              .cmd("launch")
                              .title(title)
                              .type(
                                type
                                  .to_s
                                  .gsub("_", "-")
                              )
                              .unless(
                                focus
                              ) { keep_focus }
                              .arg(arg)
                              .cmd_with_args

    @windows << title

    cmd
  end

  def close_last = close(@windows.last)

  def close(title)
    return unless @windows.include?(title)

    @windows -= [title]

    Elden::KittyShellCommand.new
                            .cmd("close-window")
                            .title(title)
                            .cmd_with_args
  end

  private

  def default_title = "elden-#{SecureRandom.uuid}"
end

class NeoVim # rubocop:todo Style/Documentation
  def initialize = @neovim = Elden::NeoVimShellCommand.new

  %w[clean compile sync].each do |cmd|
    define_method "packer_#{cmd}" do
      add_cmd("Packer#{cmd.capitalize}")
    end
  end

  def with(opts = nil, &)
    instance_exec(opts, &)
    cmd_with_args
  end

  def use_config(path)  = update(:config, path)
  def treesitter_update = add_cmd("TSUpdateSync")
  def cmd_with_args     = @neovim.cmd_with_args

  private

  def update(method, param)
    @neovim.send(method, param)
    self
  end

  def add_cmd(cmd) = update(:cmd, cmd)
end

module Elden
  class Shell # rubocop:todo Style/Documentation
    def initialize(kitty, paths)
      @kitty = kitty
      @paths = paths
    end

    def launch_dev(kitty_title: nil, sync_packer: false)
      @kitty.launch_os_window(
        title: kitty_title,
        arg: with_neovim(path: @paths.nvim_dev_config_path) do |opts|
          use_config(opts[:path])
          packer_sync if sync_packer
        end
      )
    end

    def close_last = @kitty.close_last

    def update_plugins
      @kitty.launch_window(
        arg: with_neovim do
          packer_sync
          treesitter_update
        end,
        focus: false
      )
    end

    private

    def with_neovim(opts = nil, &) = NeoVim.new.with(opts, &)
  end
end

module Elden
  class CLI < Thor # rubocop:todo Style/Documentation
    desc "dev", "Starts a development environment"
    option :kitty_title, aliases: "k", desc: "Sets the title of the created Kitty window"
    option :sync_packer, aliases: "s", type: :boolean, desc: "Runs the PackerSync command after launch"
    def dev = p elden.launch_dev(kitty_title: options[:kitty_title], sync_packer: options[:sync_packer])

    private

    def elden = Elden::Shell.new(Kitty.new, Elden::Paths.new)
  end
end

@paths  = Elden::Paths.new
@neovim = NeoVim.new
@kitty  = Kitty.new
@shell  = Elden::Shell.new(@kitty, @paths)
