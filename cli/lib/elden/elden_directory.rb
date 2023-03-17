# frozen_string_literal: true

require_relative "paths"
require_relative "shell_command"

module Elden
  module EldenDirectory
    include Elden::Paths
    include Elden::ShellCommand

    def sync_elden_directory
      arguments = %w[cp -r]

      arguments << elden_path!

      arguments << vim_config_path!

      arguments
    end
  end
end
