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

  module ShellCommands
    module Extensions # rubocop:todo Style/Documentation
      def shell_command(arguments) = arguments.join(" ").strip
    end

    class Kitty # rubocop:todo Style/Documentation
      include Elden::ShellCommands::Extensions

      def initialize = @windows = []

      %w[window tab os_window overlay overlay_main background].each do |type|
        define_method "launch_#{type}" do |title: nil, argument: "", focus: true|
          launch(type, title:, argument:, focus:)
        end
      end

      def launch(type, title: nil, argument: "", focus: true)
        return if window_exists?(title)

        title ||= default_title

        @windows << title

        arguments = kitty_command(%W[launch --title #{title} --type #{type.gsub("_", "-")}])

        arguments << "--keep-focus" unless focus

        arguments << argument unless argument.empty?

        shell_command(arguments)
      end

      def window_exists?(title) = !title.nil? && @windows.include?(title)
      def close_last            = close(@windows.last)

      def close(title)
        return unless window_exists?(title)

        @windows -= [title]

        kitty_command(%W[close-window --title #{title}]).format
      end

      private

      def kitty_command(arguments) = %w[kitty @] << arguments
      def default_title            = "elden-#{SecureRandom.uuid}"
    end

    class NeoVim # rubocop:todo Style/Documentation
      include Elden::ShellCommands::Extensions

      def initialize = @arguments = %w[nvim]

      %w[clean compile sync].each do |packer_command|
        define_method "packer_#{packer_command}" do
          add_vim_command("Packer#{packer_command.capitalize}")
        end
      end

      def use_config(path)  = add_argument("-u ", path)
      def treesitter_update = add_vim_command("TSUpdateSync")
      def to_s              = shell_command(@arguments)

      private

      def add_vim_command(vim_command)   = add_argument("+", vim_command)
      def add_argument(prefix, argument) = @arguments << "#{prefix}#{argument}"
    end
  end

  class Shell < Elden::ShellCommands::Kitty # rubocop:todo Style/Documentation
    def initialize
      @paths = Elden::Paths.new
      super
    end

    def launch_dev(kitty_title: nil, sync_packer: false)
      launch_os_window(
        title: kitty_title,
        argument: with_neovim(path: @paths.nvim_dev_config_path) do |opts|
          use_config(opts[:path])
          packer_sync if sync_packer
        end
      )
    end

    def update_plugins
      launch_window(
        argument: with_neovim do
          packer_sync
          treesitter_update
        end,
        focus: false
      )
    end

    def with_neovim(opts = nil, &)
      neovim = Elden::ShellCommands::NeoVim.new
      neovim.instance_exec(opts, &)
      neovim.to_s
    end
  end

  class CLI < Thor # rubocop:todo Style/Documentation
    desc "dev", "Starts a development environment"
    option :kitty_title, aliases: "k", desc: "Sets the title of the created Kitty window"
    option :sync_packer, aliases: "s", type: :boolean, desc: "Runs the PackerSync command after launch"
    def dev = p elden_shell.launch_dev(kitty_title: options[:kitty_title], sync_packer: options[:sync_packer])

    private

    def elden_shell = Elden::Shell.new
  end
end
