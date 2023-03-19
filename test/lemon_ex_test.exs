defmodule LemonExTest do
  use ExUnit.Case
  doctest LemonEx

  test "greets the world" do
    assert LemonEx.hello() == :world
  end
end
