defmodule CryptexTest do
  use ExUnit.Case
  doctest Cryptex

  test "greets the world" do
    assert Cryptex.hello() == :world
  end
end
