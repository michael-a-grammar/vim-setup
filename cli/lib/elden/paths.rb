# frozen_string_literal: true

module Elden
  module Paths
    [
      {
        method_name: "elden_path",
        env_name: "ELDEN_PATH"
      },
      {
        method_name: "vim_dev_config_file_path",
        env_name: "ELDEN_PATH",
        paths: "dev.vim"
      },
      {
        method_name: "config_path",
        env_name: "XDG_CONFIG_HOME",
        default: "~/",
        paths: ".config"
      },
      {
        method_name: "vim_config_path",
        env_name: "XDG_CONFIG_HOME",
        default: "~/",
        paths: %w[.config nvim]
      }
    ].each do |path_info|
      method_name, method_block =
        case path_info
        in method_name:, **rest
          method_block =
            case rest
            in env_name:, default:, paths:
              -> { env_path(env_name, paths, default:) }
            in env_name:, paths:
              -> { env_path(env_name, paths) }
            in env_name:
              -> { env_path(env_name) }
            end

          [method_name, method_block]
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

      define_method(method_name)       { path_result.call(:path)   }
      define_method("#{method_name}?") { path_result.call(:exists) }
      define_method("#{method_name}!") { path_result.call(:ensure) }
    end

    def self.path(path, *paths)
      unless path.nil?
        expanded_path = File.expand_path(path)

        paths.prepend(expanded_path)
      end

      joined_paths = File.join(paths) || ""

      exist?(joined_paths)
    end

    def self.env_path(env_name, *paths, default: nil)
      env_path_or_default = ENV[env_name] || default

      path(env_path_or_default, paths)
    end

    def self.exist?(path)
      exists = File.exist?(path)

      { exists:, path: }
    end
  end
end
