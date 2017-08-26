defmodule Cryptex.API.Summary do 
  @moduledoc """
  
  """
  use Cryptex.Resource

  @spec list :: [Types.Summary.t]
  def list do
    "/markets/summaries"
    |> Client.get
    |> parse
  end

  @spec get(Cryptex.exchange, Cryptex.market) :: Types.Summary.t
  def get(exchange, market) do
    "/markets/#{exchange}/#{market}/summary"
    |> Client.get
    |> parse(exchange, market)
  end

  @spec parse(Cryptex.exchange, Cryptex.market, map) :: Types.Summary.t
  def parse(response, exchange, market) do
    params = %{exchange: exchange, market: market} |> Map.merge(response.result)
    struct(Types.Summary, params)
  end

  @spec parse(map) :: [Types.Summary.t]
  def parse(%{result: result}) do
    result
    |> Enum.map(fn {name, result} -> 
      params = 
        name 
        |> Utils.parse_pair
        |> Map.merge(result)

      struct(Types.Summary, params) 
    end)
  end

end 
