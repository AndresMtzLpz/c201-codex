defmodule CODEXTest do
  use ExUnit.Case
  doctest CODEX

  test "greets the world" do
    assert CODEX.hello() == :world
  end
end
