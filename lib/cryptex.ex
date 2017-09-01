defmodule Cryptex do
  @moduledoc """
  Documentation for Cryptex.
  """
  alias Cryptex.{API, Types, Client}

  @type exchange :: binary
  @type market :: binary

  @doc """
  List all available exchange-market summaries
  """
  @spec list_summaries :: [Types.Summary.t]
  def list_summaries do
    API.Summary.list()
  end

  @doc """
  Get summary for exchange and market
  """
  @spec get_summary(exchange, market, keyword) :: Types.Summary.t
  def get_summary(exchange, market, opts \\ []) do
    API.Summary.get(exchange, market, opts)
  end

  @doc """
  List trades for exchange and market

  ## Options

    * `limit` - Limit number of trades returned
    * `since` - Only return trades since timestamp
  """
  @spec list_trades(exchange, market, keyword, keyword) :: [Types.Trade.t]
  def list_trades(exchange, market, params \\ [], opts \\ []) do
    API.Trade.list(exchange, market, cast_params(params))
  end

  @doc """
  List trades for exchange and market

  ## Options

    * `before` - Only return candles opening before timestamp
    * `after` - Only return candles opening after timestamp
    * `period` - Fetch candles grouped by period in seconds
  """
  @spec list_candles(exchange, market, keyword, keyword) :: [Types.Candle.t]
  def list_candles(exchange, market, params \\ [], opts \\ []) do
    API.Candle.list(exchange, market, cast_params(params), opts)
  end

  @spec cast_params(keyword) :: keyword
  defp cast_params(params) do
    params
    |> Enum.map(fn {key, value} ->
      case value do
        %DateTime{} = value -> {key, DateTime.to_unix(value)}
        _ -> {key, value}
      end
    end)
  end

end
