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

end
