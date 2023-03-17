# frozen_string_literal: true

require_relative "paths"
require_relative "shell_command"

module Elden
  module VimConfigDirectory
    include Elden::Paths
    include Elden::ShellCommand

    def backup_vim_config_directory(backup_location); end

    def purge_vim_config_directory
      arguments = %w[rm -rf]

      arguments << vim_config_path!

      arguments
    end
  end
end
