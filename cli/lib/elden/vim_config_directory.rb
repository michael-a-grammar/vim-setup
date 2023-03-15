# frozen_string_literal: true

require_relative "paths"
require_relative "shell_command"

class VimConfigDirectory # rubocop:todo Style/Documentation
  include Elden::ShellCommand

  def initialize = @paths = Elden::Paths.new

  def backup(backup_location); end

  def purge
    arguments = %w[rm -rf]

    arguments << @paths.vim_config_path

    arguments
  end
end
