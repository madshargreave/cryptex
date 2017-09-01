defmodule Cryptex.API.Candle do 
  @moduledoc """
  
  """
  use Cryptex.Resource

  @spec list(Cryptex.exchange, Cryptex.market, keyword, keyword) :: [Types.Candle.t]
  def list(exchange, market, params \\ [], opts \\ []) do
    params = [before: params[:before], after: params[:after], periods: params[:period]]

    "/markets/#{exchange}/#{market}/ohlc"
    |> Client.get(params, opts)
    |> parse(exchange, market, params)
  end

  @spec parse(map, Cryptex.exchange, Cryptex.market, keyword) :: [Types.Candle.t]
  defp parse(response, exchange, market, params) do
    (response.result || [])
    |> Map.get(:"#{params[:periods]}")
    |> Enum.map(fn [closed_at, open, high, low, close, volume] -> 
      struct(Types.Candle, %{
        exchange: exchange, 
        market: market, 
        closed_at: DateTime.from_unix!(closed_at),
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume}) 
    end)
  end

end 
