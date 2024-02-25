# frozen_string_literal: true

module Elden
  module Paths
    def self.included(base)
      base.extend(Elden::Paths)

      [
        {
          name: :elden_source_path,
          env_name: "ELDEN_PATH"
        },
        {
          name: :elden_init_file_path,
          parent_path: :elden_source_path,
          path: "init.lua"
        },
        {
          name: :elden_dev_file_path,
          parent_path: :elden_source_path,
          path: "dev.vim"
        },
        {
          name: :elden_lua_path,
          parent_path: :elden_source_path,
          path: "elden"
        }
        {
          name: :config_path,
          env_name: "XDG_CONFIG_HOME",
          default_path: "~/",
          path: ".config"
        },
        {
          name: :vim_config_path,
          parent_path: :config_path,
          path: "nvim"
        },
        {
          name: :vim_lua_path,
          parent_path: :vim_config_path,
          path: "lua"
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
              in parent_path:, path:
                -> { get_path(base, parent_path, path) }
              end

            [name, method_block]
          end

        path_cmd = proc do |cmd|
          method_block.call => {exists:, path:}

          case cmd
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
            cmd: :path
          },
          {
            name: "#{path_name}?",
            cmd: :exists
          },
          {
            name: "#{path_name}!",
            cmd: :ensure
          }
        ].each do |method_info|
          define_method(method_info[:name]) { path_cmd.call(method_info[:cmd]) }
        end
      end
    end

    def self.get_path_from_env(env_name, default_path = nil, path = nil)
      parent_path = ENV[env_name] || default_path

      get_path_result(parent_path, path)
    end

    def self.get_path(base, parent_path_method, path)
      parent_path = base.send(parent_path_method)

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
