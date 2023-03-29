# frozen_string_literal: true

require          "fileutils"
require_relative "paths"
require_relative "shell_command"

module Elden
  module EldenDirectory
    include Elden::Paths

    def elden_directory_sync!(verbose: true)
      FileUtils.cp_r(elden_path!, config_path!, verbose:)
    end
  end
end
