defmodule MyList do
  def span(from, to), do: _span(from, to, [])
  defp _span(from, from, list), do: list
  defp _span(from, to, list), do: _span(from, to-1, [ to | list ])
end
