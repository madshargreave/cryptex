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
  List summary for exchange and market
  """
  @spec get_summary(exchange, market) :: Types.Summary.t
  def get_summary(exchange, market) do
    API.Summary.get(exchange, market)
  end

end
