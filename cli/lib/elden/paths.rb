# frozen_string_literal: true

module Elden
  module Paths
    [
      {
        name: "elden_source_path",
        env_name: "ELDEN_PATH"
      },
      {
        name: "elden_dev_config_file_path",
        env_name: "ELDEN_PATH",
        additional_paths: "dev.vim"
      },
      {
        name: "config_path",
        env_name: "XDG_CONFIG_HOME",
        default_path: "~/",
        additional_paths: ".config"
      },
      {
        name: "vim_config_path",
        env_name: "XDG_CONFIG_HOME",
        default_path: "~/",
        additional_paths: %w[.config nvim]
      },
      {
        name: "vim_lua_path",
        env_name: "XDG_CONFIG_HOME",
        default_path: "~/",
        additional_paths: %w[.config nvim lua]
      },
      {
        name: "elden_deploy_path",
        env_name: "XDG_CONFIG_HOME",
        default_path: "~/",
        additional_paths: %w[.config nvim lua elden]
      }
    ].each do |path_info|
      name, method_block =
        case path_info
        in name:, **rest
          method_block =
            case rest
            in env_name:, default_path:, additional_paths:
              -> { env_path(env_name, additional_paths, default_path:) }
            in env_name:, additional_paths:
              -> { env_path(env_name, additional_paths) }
            in env_name:
              -> { env_path(env_name) }
            end

          [name, method_block]
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

      define_method(name)       { path_result.call(:path)   }
      define_method("#{name}?") { path_result.call(:exists) }
      define_method("#{name}!") { path_result.call(:ensure) }
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
      env_path_or_default = ENV[env_name] || default_path

      path(env_path_or_default, additional_paths)
    end

    def self.exist?(path)
      exists = File.exist?(path)

      { exists:, path: }
    end
  end
end
