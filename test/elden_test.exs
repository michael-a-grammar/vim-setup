defmodule EldenTest do
  use ExUnit.Case
  doctest Elden

  test "greets the world" do
    assert Elden.hello() == :world
  end
end
