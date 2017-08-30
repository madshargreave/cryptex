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

defmodule Cryptex.Types.Candle do
  defstruct exchange: nil, market: nil, open: nil, close: nil, high: nil, low: nil, volume: nil, closed_at: nil

  @type t :: %__MODULE__{
    exchange: binary,
    market: binary,
    open: float, 
    close: float, 
    high: float, 
    low: float, 
    volume: float, 
    closed_at: DateTime.t
  }

end
