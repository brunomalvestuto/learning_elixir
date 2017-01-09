# Exercise 6

defmodule Chop do
  def guess(actual, range = low..high) do
    guess = low + div(high - low, 2)
    IO.puts("Is it #{guess} ?")
    guess(guess, actual, range)
  end

  defp guess(actual, actual, _), do: IO.puts(actual)

  defp guess(guess, actual, low.._) when guess > actual do
    guess(actual, low..guess)
  end

  defp guess(guess, actual, _..high) when guess < actual do
    guess(actual, guess..high)
  end
end
