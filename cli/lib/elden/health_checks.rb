# frozen_string_literal: true

module Elden
  module HealthChecks
    include Elden::Paths

    def elden_source_path_exists?
      true
    end
  end
end
