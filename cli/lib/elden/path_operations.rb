# frozen_string_literal: true

require          "fileutils"
require_relative "paths"

module Elden
  module PathOperations
    include Elden::Paths

    def elden_source_directory_sync!(verbose: true)
      FileUtils.cp_r(elden_lua_path!, vim_lua_path!, verbose:)
    end

    def elden_deploy_directory_purge!(verbose: true)
      FileUtils.rm_rf(elden_deploy_path!, secure: true, verbose:)
    end
  end
end
