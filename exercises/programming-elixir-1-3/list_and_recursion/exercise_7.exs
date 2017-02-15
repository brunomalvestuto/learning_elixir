defmodule PrimeNumbers do
  Code.require_file("exercise_4.exs")

  def until(n) do
     for x <- MyList.span(2,n), prime_number?(x), do: IO.inspect(x)
  end

  def enum_until(n) do
    MyList.span(2,n) |> Enum.filter(&prime_number?/1)
  end

  defp prime_number?(n) do
    2..n |> Enum.all?(fn(x) -> x == n || rem(n,x) != 0 end)
  end
end
