# frozen_string_literal: true

require_relative "elden/version"

module Elden
  class CLI
    @commands = %i[dev sync update]

    def self.start
      elden_path  = get_env_path("ELDEN_PATH")
      config_path = get_env_path("XDG_CONFIG_HOME", "~/", ".config", "nvim")

      puts [elden_path, config_path]
      # `kitty @ launch --type='os-window' nvim`
    end

    def self.get_env_path(name, default = "", *paths)
      joined_path =
        File.join(
          File.expand_path(
            ENV[name] || default
          ),
          paths
        )

      File.exist?(joined_path) ? joined_path : false
    end
  end
end
