# frozen_string_literal: true

module Elden
  class Paths # rubocop:todo Style/Documentation
    attr_reader :elden_path, :vim_config_path, :vim_dev_config_file_path

    def initialize
      @elden_path                = env_path("ELDEN_PATH")
      @vim_config_path           = env_path("XDG_CONFIG_HOME", ".config", "nvim", default: "~/")
      @vim_dev_config_file_path  = path(@elden_path, "dev.vim")
    end

    private

    def path(path, *paths)
      joined_path =
        File.join(
          File.expand_path(
            path
          ),
          paths
        )

      exist?(joined_path)
    end

    def env_path(name, *paths, default: "") = path(ENV[name] || default, paths)
    def exist?(path)                        = File.exist?(path) ? path : false
  end
end
