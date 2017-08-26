defmodule Cryptex.Resource do
  @moduledoc false
  alias Cryptex.Types

  defmacro __using__(_opts) do
    quote do
      alias Cryptex.{Types, Client, Utils}
    end
  end

end 
