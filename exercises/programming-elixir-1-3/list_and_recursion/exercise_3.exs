defmodule MyList do
  @alphabet_letter 26

  def caesar([], _), do: []

  def caesar([head | tail], shift) when head + shift <= ?z do
    [ head + shift | caesar(tail, shift) ]
  end

  def caesar([head | tail ], shift) do
    [ head + shift-26  | caesar(tail, shift) ]
  end
end
