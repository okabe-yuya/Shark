defmodule SharkTest do
  use ExUnit.Case
  doctest Shark

  test "greets the world" do
    assert Shark.hello() == :world
  end
end
