# frozen_string_literal: true

module Elden
  module Paths
    [
      {
        path_name: "elden_path",
        env_name: "ELDEN_PATH"
      },
      {
        path_name: "vim_dev_config_file_path",
        env_name: "ELDEN_PATH",
        additional_paths: "dev.vim"
      },
      {
        path_name: "config_path",
        env_name: "XDG_CONFIG_HOME",
        default_path: "~/",
        additional_paths: ".config"
      },
      {
        path_name: "vim_config_path",
        env_name: "XDG_CONFIG_HOME",
        default_path: "~/",
        additional_paths: %w[.config nvim]
      }
    ].each do |path_info|
      path_name, method_block =
        case path_info
        in path_name:, **rest
          method_block =
            case rest
            in env_name:, default_path:, additional_paths:
              -> { env_path(env_name, additional_paths, default_path:) }
            in env_name:, additional_paths:
              -> { env_path(env_name, additional_paths) }
            in env_name:
              -> { env_path(env_name) }
            end

          [path_name, method_block]
        end

      path_result = proc do |pattern|
        method_block.call => {exists:, path:}

        case pattern
        in :path
          path
        in :exists
          exists
        in :ensure
          raise "Path '#{path}' does not exist" unless exists

          path
        end
      end

      define_method(path_name)       { path_result.call(:path)   }
      define_method("#{path_name}?") { path_result.call(:exists) }
      define_method("#{path_name}!") { path_result.call(:ensure) }
    end

    def self.path(path, *additional_paths)
      unless path.nil?
        expanded_path = File.expand_path(path)

        additional_paths.prepend(expanded_path)
      end

      joined_paths = File.join(additional_paths) || ""

      exist?(joined_paths)
    end

    def self.env_path(env_name, *additional_paths, default_path: nil)
      env_path_or_default = ENV[env_name] || default

      path(env_path_or_default, additional_paths)
    end

    def self.exist?(path)
      exists = File.exist?(path)

      { exists:, path: }
    end
  end
end
