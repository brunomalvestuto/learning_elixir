defmodule MyList do
  def mapsum(list, fun), do: _mapsum(list, fun, 0)

  defp _mapsum([], _, total), do: total

  defp _mapsum([head | tail], fun, total) do
    total = total + fun.(head)
    _mapsum(tail, fun, total)
  end

end
