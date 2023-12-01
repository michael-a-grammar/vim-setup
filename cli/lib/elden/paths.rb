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
        parent_path_method_name: :elden_source_path,
        path_leaf: "dev.vim"
      },
      {
        name: "config_path",
        env_name: "XDG_CONFIG_HOME",
        default_path: "~/",
        path_leaf: ".config"
      },
      {
        name: "vim_config_path",
        parent_path_method_name: :config_path,
        path_leaf: "nvim",
        methods: :purge
      },
      {
        name: "vim_lua_path",
        parent_path_method_name: :vim_config_path,
        path_leaf: "lua",
        methods: :purge
      },
      {
        name: "elden_deploy_path",
        parent_path_method_name: :vim_lua_path,
        path_leaf: "elden",
        methods: %i[purge sync]
      }
    ].each do |path_info|
      path_name, method_block =
        case path_info
        in name:, **rest
          method_block =
            case rest
            in env_name:, default_path:, path_leaf:
              -> { get_path_from_env(env_name, default_path, path_leaf) }
            in env_name:
              -> { get_path_from_env(env_name) }
            in parent_path_method_name:, path_leaf:
              -> { get_path_using_parent_path_method(parent_path_method_name, path_leaf) }
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

    def self.get_path_from_env(env_name, default_path = nil, path_leaf = nil)
      path_tree = ENV[env_name] || default_path

      get_path_result(path_tree, path_leaf)
    end

    def self.get_path_using_parent_path_method(parent_path_method_name, path_leaf)
      path_tree = send(parent_path_method_name)

      get_path_result(path_tree, path_leaf)
    end

    def self.get_path_result(path_tree, path_leaf)
      path =
        case { path_tree:, path_leaf: }
        in { path_tree:, path_leaf: } unless path_tree.nil? || path_leaf.nil?
          File.join(path_tree, path_leaf)
        in { path_tree:, path_leaf: } if path_tree.nil?
          path_leaf
        in { path_tree:, path_leaf: } if path_leaf.nil?
          path_tree
        else
          ""
        end

      path = File.expand_path(path)

      path_exists?(path)
    end

    def self.path_exists?(path)
      exists = File.exist?(path)

      { exists:, path: }
    end
  end
end
