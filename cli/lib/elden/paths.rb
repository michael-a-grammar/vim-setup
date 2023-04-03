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

      define_method(method_name) do
        method_block.call => {exists:, path:}

        path
      end

      define_method("#{method_name}?") do
        method_block.call => {exists:, path:}

        exists
      end

      define_method("#{method_name}!") do
        method_block.call => {exists:, path:}

        raise "Path '#{path}' does not exist" unless exists

        path
      end
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
