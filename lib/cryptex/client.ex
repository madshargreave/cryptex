defmodule Cryptex.Client do
  @moduledoc false
  use HTTPoison.Base
  require Logger

  alias Cryptex.Utils
  alias HTTPoison.Response

  @type response :: nil | {integer, any} | Poison.Parser.t

  @spec process_url(binary) :: binary
  def process_url(endpoint) do
    "https://api.cryptowat.ch" <> endpoint
  end

  @spec process_response(Response.t) :: Poison.Parser.t
  def process_response({:ok, %Response{status_code: 200, body: ""}}), do: nil
  def process_response({:ok, %Response{status_code: 200, body: body}}), do: Poison.decode!(body) |> process_response
  def process_response({:ok, %Response{status_code: status_code, body: ""}}), do: {status_code, nil}
  def process_response({:ok, %Response{status_code: status_code, body: body}}), do: {status_code, Poison.decode!(body)}
  def process_response(body) when is_map(body), do: AtomicMap.convert(body, safe: false, underscore: false)

  @spec get(binary, keyword, keyword) :: response
  def get(path, params \\ [], opts \\ []) do
    _request(:get, path, params, opts)
    |> process_response 
  end

  @spec _request(term, binary, keyword, keyword) :: Response.t
  defp _request(method, path, params \\ [], opts \\ []) do
    opts = Keyword.merge([params: Utils.cast_params(params)], opts)
    request(method, path, "", [], opts)
  end

  @spec print_allowance(Response.t) :: Response.t
  def print_allowance(response) do
    cost = response.allowance.cost
    remaining = response.allowance.remaining
    Logger.info "[#{__MODULE__}]: Cost: #{cost} Remaining: #{remaining} (#{round(remaining / cost)} requests left)"
    response
  end

end 
