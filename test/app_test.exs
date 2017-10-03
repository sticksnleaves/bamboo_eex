defmodule AppTest do
  use ExUnit.Case
  doctest Bamboo.EEx

  test "greets the world" do
    assert Bamboo.EEx.hello() == :world
  end
end
