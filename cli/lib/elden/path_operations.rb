# frozen_string_literal: true

require          "fileutils"
require_relative "paths"

module Elden
  module PathOperations
    include Elden::Paths

    def elden_source_directory_sync!(verbose: true)
      FileUtils.cp_r(elden_source_path!, vim_config_path!, verbose:)
    end

    def vim_lua_directory_purge!(verbose: true)
      FileUtils.rm_rf(vim_lua_path!, secure: true, verbose:)
    end
  end
end
