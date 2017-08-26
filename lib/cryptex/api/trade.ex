defmodule Cryptex.API.Trade do 
  @moduledoc """
  
  """
  use Cryptex.Resource

  @spec list(Cryptex.exchange, Cryptex.market, keyword) :: [Types.Trade.t]
  def list(exchange, market, opts \\ []) do
    "/markets/#{exchange}/#{market}/trades"
    |> Client.get(opts)
    |> parse(exchange, market)
  end

  @spec parse(map, Cryptex.exchange, Cryptex.market) :: [Types.Trade.t]
  defp parse(response, exchange, market) do
    (response.result || [])
    |> Enum.map(fn [id, timestamp, price, amount] -> 
      struct(Types.Trade, %{exchange: exchange, market: market, id: id, timestamp: DateTime.from_unix!(timestamp), price: price, amount: amount}) 
    end)
  end

end 
