# frozen_string_literal: true

require          "fileutils"
require_relative "paths"
require_relative "shell_command"

module Elden
  module VimConfigDirectory
    include Elden::Paths

    def vim_config_directory_backup!(backup_location); end

    def vim_config_directory_purge!(verbose: true)
      FileUtils.rm_rf(vim_config_path, verbose:) if vim_config_path?
    end
  end
end
