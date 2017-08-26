defmodule Cryptex.Client do
  @moduledoc """
  
  """
  use HTTPoison.Base
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

  @spec get(binary, keyword) :: response
  def get(path, params \\ []) do
    request(:get, path, "", [], params: params) 
    |> process_response 
  end

end 
