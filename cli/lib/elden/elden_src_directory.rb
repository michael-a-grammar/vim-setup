# frozen_string_literal: true

require          "fileutils"
require_relative "paths"
require_relative "shell_command"

module Elden
  module EldenSrcDirectory
    include Elden::Paths

    def elden_src_directory_sync!(verbose: true)
      FileUtils.cp_r(elden_src_path!, config_path, verbose:)
    end
  end
end
