defmodule Cryptex.API.Candle do 
  @moduledoc """
  
  """
  use Cryptex.Resource

  @spec list(Cryptex.exchange, Cryptex.market, keyword) :: [Types.Candle.t]
  def list(exchange, market, opts \\ []) do
    opts = [periods: opts[:period]]

    "/markets/#{exchange}/#{market}/ohlc"
    |> Client.get(opts)
    |> parse(exchange, market, opts)
  end

  @spec parse(map, Cryptex.exchange, Cryptex.market, keyword) :: [Types.Candle.t]
  defp parse(response, exchange, market, opts) do
    (response.result || [])
    |> Map.get(:"#{opts[:periods]}")
    |> Enum.map(fn [closed_at, open, high, low, close, volume] -> 
      struct(Types.Candle, %{
        exchange: exchange, 
        market: market, 
        closed_at: closed_at,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume}) 
    end)
  end

end 
