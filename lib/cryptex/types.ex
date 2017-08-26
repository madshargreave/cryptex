defmodule Cryptex.Types.Summary do
  defstruct exchange: nil, market: nil, price: nil, volume: nil

  @type t :: %__MODULE__{
    exchange: binary,
    market: binary,
    volume: float,
    price: %{
      last: float,
      high: float,
      low: float,
      change: %{
        absolute: float,
        percentage: float
      }
    }
  }

end
