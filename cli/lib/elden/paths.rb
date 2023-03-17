# frozen_string_literal: true

module Elden
  class Paths
    [
      {
        method_name: "elden_path",
        env_name: "ELDEN_PATH"
      },
      {
        method_name: "vim_config_path",
        env_name: "XDG_CONFIG_HOME",
        default: "~/",
        paths: %w[.config nvim]
      },
      {
        method_name: "vim_dev_config_file_path",
        base_path: "elden_path",
        paths: "dev.vim"
      }
    ].each do |path_info|
      method_name, method_block =
        case path_info
        in method_name:, **rest
          method_block =
            case rest
            in env_name:, default:, paths:
              -> { env_path(env_name, paths, default:) }
            in env_name:
              -> { env_path(env_name) }
            in base_path:, paths:
              lambda {
                path(
                  send(
                    "#{base_path}!"
                  ),
                  paths
                )
              }
            end

          [method_name, method_block]
        end

      self.class.define_method(method_name, method_block)

      self.class.define_method("#{method_name}!") do
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
