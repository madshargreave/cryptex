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

defmodule Cryptex.Types.Trade do
  defstruct exchange: nil, market: nil, id: nil, price: nil, amount: nil, timestamp: nil

  @type t :: %__MODULE__{
    exchange: binary,
    market: binary,
    id: integer,
    timestamp: DateTime.t,
    price: float,
    amount: float
  }

end
