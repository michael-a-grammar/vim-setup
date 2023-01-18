defmodule Elden do
  @commands [:install, :sync, :dev]

  def main(args) do
    IO.inspect(args)

    case args do
      [command] -> nil
      [command | _] -> nil
      [] -> nil
    end

    Enum.map(args, fn arg ->
      arg
      |> String.to_atom()
      |> then(fn command ->
        @commands
        |> Enum.member?(command)
        |> then(fn
          true ->
            {:ok, command}

          false ->
            {:error, command}
        end)
      end)
    end)
    |> Enum.each(fn
      {:ok, _} -> 2
      {:error, _} -> 2
    end)
  end
end
