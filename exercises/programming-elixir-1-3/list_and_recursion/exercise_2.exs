defmodule MyList do
  def max([head | tail]), do: _max(head, tail)

  defp _max(max, []), do: max
  defp _max(max, [ head | tail ]) when head > max, do: _max(head, tail)
  defp _max(max, [ _ | tail ]), do: _max(max, tail)
end
