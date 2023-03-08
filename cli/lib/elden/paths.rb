# frozen_string_literal: true

module Elden
  class Paths # rubocop:todo Style/Documentation
    attr_reader :elden_path, :config_path, :nvim_dev_config_path

    def initialize
      @elden_path           = env_path("ELDEN_PATH")
      @config_path          = env_path("XDG_CONFIG_HOME", ".config", "nvim", default: "~/")
      @nvim_dev_config_path = path(@elden_path, "dev.vim")
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
