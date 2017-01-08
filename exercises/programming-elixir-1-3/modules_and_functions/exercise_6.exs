# Exercise 6
require IEx;
defmodule Chop do
  def guess(actual, range), do: _guess(nil, actual ,range)

  def _guess(nil, actual, range = _..ending) do
    guess = div(ending, 2)
    IO.puts("Is it #{guess} ?")
    _guess(guess, actual, range)
  end

  def _guess(actual, actual, _), do: IO.puts(actual)

  def _guess(guess, actual, beginning.._) when guess > actual do
    guess = beginning + div((guess - beginning), 2)
    IO.puts("Is it #{guess} ?")
    _guess(guess, actual, beginning..guess)
  end

  def _guess(guess, actual, beginning..ending) when guess < actual do
    next_guess = guess +  div((guess - beginning), 2) + 1
    IO.puts("Is it #{next_guess} ?")
    _guess(next_guess, actual, guess..ending)
  end


end
