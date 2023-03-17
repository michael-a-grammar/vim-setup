# frozen_string_literal: true

require_relative "paths"
require_relative "shell_command"

module Elden
  class EldenDirectory
    include Elden::ShellCommand

    def sync
      arguments = %w[cp -r]

      arguments << Elden::Paths.elden_path!

      arguments << Elden::Paths.vim_config_path!

      arguments
    end
  end
end
