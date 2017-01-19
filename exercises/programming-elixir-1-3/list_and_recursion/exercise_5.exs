defmodule MyEnum do

  def all?(list, fun \\ fn(_) -> true end )
  def all?([], _), do: true
  def all?([element | tail], fun) do
    if element != nil && fun.(element)  do
      all?(tail, fun)
    else
      false
    end
  end


  def each([], _), do: :ok
  def each([head | tail], fun) do
    fun.(head)
    each(tail, fun)
  end

  def filter(list, fun), do: _filter(list, fun, [])
  defp _filter([], _, acc), do: acc
  defp _filter([element | tail], fun, acc) do

    if fun.(element) do
      _filter(tail, fun, [ element | acc ] )
    else
      _filter(tail, fun, acc )
    end
  end


  def split(list, count), do: _split(list, count, [])

  defp _split(list, 0, acc), do: { Enum.reverse(acc), list }
  defp _split([], _, acc), do:  { Enum.reverse(acc), [] }
  defp _split([head | tail], count, acc)  do
    _split(tail, count-1, [ head | acc ] )
  end

  def take(list, count), do: _take(list, count, [])
  defp _take(_, 0, acc), do: Enum.reverse(acc)
  defp _take([], _, acc), do: Enum.reverse(acc)
  defp _take([head | tail], count, acc), do: _take(tail, count-1, [ head | acc])
end
