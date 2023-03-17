# frozen_string_literal: true

require_relative "paths"
require_relative "shell_command"

module Elden
  class EldenDirectory
    include Elden::ShellCommand
  end
end
