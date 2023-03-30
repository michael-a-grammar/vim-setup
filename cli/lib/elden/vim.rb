# frozen_string_literal: true

require_relative "shell_command"

module Elden
  class Vim
    include Elden::ShellCommand

    attr_reader :arguments

    def initialize = @arguments = %w[nvim]

    %w[clean compile sync].each do |packer_command|
      shell_command
      define_method("packer_#{packer_command}") do
        add_vim_command("Packer#{packer_command.capitalize}")
      end
    end

    shell_command
    def use_config(path) = add_argument("-u ", path)

    shell_command
    def treesitter_update = add_vim_command("TSUpdateSync")

    private

    def add_vim_command(vim_command)   = add_argument("+", vim_command)
    def add_argument(prefix, argument) = @arguments << "#{prefix}#{argument}"
  end
end
