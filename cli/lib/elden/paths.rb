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

      define_method(method_name, method_block)

      define_method("#{method_name}!") do
        path_exists, path = method_block.call

        raise "Path '#{path}' does not exist" unless path_exists

        path
      end
    end

    def self.path(path, *paths)
      unless path.nil?
        paths.prepend(
          File.expand_path(
            path
          )
        )
      end

      exist?(
        File.join(
          paths
        ) || ""
      )
    end

    def self.env_path(name, *paths, default: nil)
      path(ENV[name] || default, paths)
    end

    def self.exist?(path)
      [File.exist?(path), path]
    end
  end
end
