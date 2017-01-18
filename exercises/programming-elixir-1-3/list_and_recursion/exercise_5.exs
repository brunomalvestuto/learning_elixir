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

end
