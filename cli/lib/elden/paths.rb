# frozen_string_literal: true

module Elden
  class Paths # rubocop:todo Style/Documentation
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
      method_name, block =
        case path_info
        in method_name:, **rest
          block =
            case rest
            in env_name:, **nil
              -> { env_path(env_name) }
            in env_name:, default:, paths:, **nil
              -> { env_path(env_name, paths, default:) }
            in base_path:, paths:, **nil
              lambda {
                path(
                  send(
                    base_path
                  )[1],
                  paths
                )
              }
            end

          [method_name, block]
        end

      define_method method_name, block
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
    def exist?(path)                        = [File.exist?(path), path]
  end
end
