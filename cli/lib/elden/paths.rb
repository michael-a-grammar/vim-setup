# frozen_string_literal: true

module Elden
  module Paths
    [
      {
        name: :elden_source_path,
        env_name: "ELDEN_PATH"
      },
      {
        name: :elden_dev_config_file_path,
        parent_path_method: :elden_source_path,
        path: "dev.vim"
      },
      {
        name: :config_path,
        env_name: "XDG_CONFIG_HOME",
        default_path: "~/",
        path: ".config"
      },
      {
        name: :vim_config_path,
        parent_path_method: :config_path,
        path: "nvim",
        methods: :purge
      },
      {
        name: :vim_lua_path,
        parent_path_method: :vim_config_path,
        path: "lua",
        methods: :purge
      },
      {
        name: :elden_deploy_path,
        parent_path_method: :vim_lua_path,
        path: "elden",
        methods: %i[purge sync]
      }
    ].each do |path_info|
      path_name, method_block =
        case path_info
        in name:, **rest
          method_block =
            case rest
            in env_name:, default_path:, path:
              -> { get_path_from_env(env_name, default_path, path) }
            in env_name:
              -> { get_path_from_env(env_name) }
            in parent_path_method:, path:
              -> { get_path(parent_path_method, path) }
            end

          [path_name, method_block]
        end

      path_delegate = proc do |delegate|
        method_block.call => {exists:, path:}

        case delegate
        in :path
          path
        in :exists
          exists
        in :ensure
          raise "Path '#{path}' does not exist" unless exists

          path
        end
      end

      [
        {
          name: path_name,
          delegate: :path
        },
        {
          name: "#{path_name}?",
          delegate: :exists
        },
        {
          name: "#{path_name}!",
          delegate: :ensure
        }
      ].each do |method_info|
        define_method(method_info.name) { path_delegate.call(method_info.delegate) }
      end
    end

    def self.get_path_from_env(env_name, default_path = nil, path = nil)
      parent_path = ENV[env_name] || default_path

      get_path_result(parent_path, path)
    end

    def self.get_path(parent_path_method, path)
      parent_path = send(parent_path_method)

      get_path_result(parent_path, path)
    end

    def self.get_path_result(parent_path, path)
      path_result =
        case { parent_path:, path: }
        in { parent_path:, path: } unless parent_path.nil? || path.nil?
          File.join(parent_path, path)
        in { parent_path:, path: } if parent_path.nil?
          path
        in { parent_path:, path: } if path.nil?
          parent_path
        else
          ""
        end

      path_result = File.expand_path(path_result)

      path_exists?(path_result)
    end

    def self.path_exists?(path)
      exists = File.exist?(path)

      { exists:, path: }
    end
  end
end
