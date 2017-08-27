defmodule Cryptex.Utils do
  @moduledoc false

  @doc """
  Parses exchange and market from a string of the format "bithumb:etckrw"
  """
  @spec parse_pair(binary | term) :: map
  def parse_pair(string) when is_atom(string), do: Atom.to_string(string) |> parse_pair
  def parse_pair(string) do
    %{exchange: do_parse_pair(:exchange, string), market: do_parse_pair(:market, string)}
  end
  defp do_parse_pair(:exchange, string), do: string |> String.split(":") |> List.first
  defp do_parse_pair(:market, string), do: string |> String.split(":") |> List.last

  @spec cast_params(keyword) :: keyword
  def cast_params(params) do
    params
    |> Enum.map(&cast_params_date/1)
  end
  defp cast_params_date({key, %NaiveDateTime{} = value}), do: {key, value |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix}
  defp cast_params_date(pair), do: pair

end
