defmodule StringAndBinaries do
  def only_printable?(list) do
    list |> Enum.all?(&(printable?(&1)))
  end

  defp printable?(ch) when (ch >= ?a and ch <= ?z) or (ch >= ?A and ch <= ?Z),  do: true
  defp printable?(_), do: false
end
