# frozen_string_literal: true

require          "securerandom"
require_relative "extensions"
require_relative "invoke"

module Elden
  module ShellCommands
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

      def close_last = close(@windows.last)

      def close(title)
        return unless window_exists?(title)

        @windows -= [title]

        kitty_command(%W[close-window --title #{title}]).format
      end

      private

      def kitty_command(arguments) = %w[kitty @] << arguments
      def default_title            = "elden-#{SecureRandom.uuid}"
      def window_exists?(title)    = !title.nil? && @windows.include?(title)

      include Elden::ShellCommands::Invoke
    end
  end
end
