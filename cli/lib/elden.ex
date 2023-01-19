defmodule Elden do
  @commands [:dev, :sync, :update]

  def main(args) do
    IO.inspect(args)

    elden_path = get_env_path("ELDEN_PATH")
    config_path = get_env_path("XDG_CONFIG_HOME", default: "~/.config", paths: ["nvim"])

    IO.inspect([elden_path, config_path])

    case args do
      [arg] ->
        arg
        |> String.to_atom()
        |> then(fn command ->
          @commands
          |> Enum.member?(command)
          |> then(fn
            true ->
              case command do
                :sync ->
                  2

                :dev ->
                  System.cmd(
                    "kitty",
                    [
                      "--session",
                      "elden.dev",
                      "--directory",
                      "#{elden_path}",
                      "--single-instance",
                      "--title",
                      "elden dev"
                    ]
                  )
              end

            false ->
              {:error, arg}
          end)
        end)

      [arg | other_args] ->
        {:error, arg, other_args}

      [] ->
        :error
    end
  end

  def get_env_path(varname, opts \\ []) do
    default = Keyword.get(opts, :default)
    paths = Keyword.get(opts, :paths, [])

    env_path =
      case System.get_env(varname) do
        nil ->
          if default != nil, do: default, else: nil

        env_path ->
          env_path
      end

    case env_path do
      nil ->
        {:error, "No system env for varname #{varname} found"}

      env_path ->
        expanded_path =
          env_path
          |> Path.expand()
          |> then(fn expanded_path ->
            [expanded_path | paths]
          end)
          |> Path.join()

        expanded_path
        |> File.dir?()
        |> then(fn
          true ->
            expanded_path

          false ->
            {:error, "Path is not a directory, #{expanded_path}"}
        end)
    end
  end
end
