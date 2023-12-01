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
        parent_path_method_name: :elden_source_path
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
        path_leaf: "nvim"
      },
      {
        name: "vim_lua_path",
        parent_path_method_name: :vim_config_path,
        path_leaf: "lua"
      },
      {
        name: "elden_deploy_path",
        parent_path_method_name: :vim_lua_path,
        path_leaf: "elden"
      }
    ].each do |path_info|
      name, method_block =
        case path_info
        in name:, **rest
          method_block =
            case rest
            in env_name:
              -> { get_path_from_env(env_name) }
            in env_name:, default_path:, path_leaf:
              -> { get_path_from_env(env_name, default_path, path_leaf) }
            in parent_path_method_name:, path_leaf:
              -> { get_path_using_parent_path_method(parent_path_method_name, path_leaf) }
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

    def self.get_path_from_env(env_name, default_path: nil, path_leaf: nil)
      path_tree = ENV[env_name] || default_path

      get_path_result(path_tree, path_leaf)
    end

    def self.get_path_using_parent_path_method(parent_path_method_name, path_leaf)
      path_tree = send(parent_path_method_name)

      get_path_result(path_tree, path_leaf)
    end

    def self.get_path_result(path_tree, path_leaf)
      path = File.expand_path(path_tree) unless path_tree.nil?

      path =
        case { path_tree, path_leaf }
        in path_tree:, path_leaf: unless path_tree.nil? || path_leaf.nil?
          File.join(path_tree, path_leaf)
        in path_tree:, path_leaf: if path_tree.nil?
          path_leaf
        in path_tree:, path_leaf: if path_leaf.nil?
          path_tree
        else
          ""
        end

      path_exists?(File.expand(path))
    end

    def self.path_exists?(path)
      exists = File.exist?(path)

      { exists:, path: }
    end
  end
end
