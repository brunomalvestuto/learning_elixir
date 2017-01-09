defmodule MyList do
  @alphabet 26

  def caesar([], _), do: []

  def caesar([head | tail], shift) when head + shift <= ?z do
    [ head + shift | caesar(tail, shift) ]
  end

  def caesar([head | tail ], shift) do
    [ head + shift-@alphabet | caesar(tail, shift) ]
  end
end
