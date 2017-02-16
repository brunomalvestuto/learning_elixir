defmodule StringsAndBinaries do
  def calculate(sqs) do
    [l, o, r ] = _parse(sqs, [], 0)
    o.(l, r)
  end

  defp _parse([], extracted, current) do
    Enum.reverse([ current | extracted ])
  end

  defp _parse([ ?\s, o, ?\s | t ], extracted, current) do
    o = case o do
      ?- ->
        &(&1-&2)
      ?+ ->
        &(&1+&2)
      ?* ->
        &(&1*&2)
      ?/ ->
        &div/2
    end

    _parse(t, [ o | [ current | extracted ] ], 0)
  end

  defp _parse([digit | t], extracted, current) do
    _parse(t, extracted, (current*10 + digit - ?0) )
  end
end

# calculate('100 * 10') #=> 1000
