defmodule SquaresTest do
  use ExUnit.Case
  doctest Squares

  test "greets the world" do
    assert Squares.hello() == :world
  end
end
