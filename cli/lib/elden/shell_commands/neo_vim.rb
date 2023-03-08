# frozen_string_literal: true

require_relative "extensions"

module Elden
  module ShellCommands
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
end
