We now have three different implementations of FizzBuzz. One uses cond, one uses case, and one uses separate functions with guard clauses.
Take a minute to look at all three. Which do you feel best expresses the problem. Which will be easiest to maintain?
The case style and the implementation using guard clauses are different from control structures in most other languages. If you feel that one of these was the best implementation, can you think of ways to remind yourself to investigate these options as you write Elixir code in the future?

# Reflection

I don't think there's much difference between the cond and case implementation, apart from the fact that cond requires a pattern match so in ordor to by pass that my implementation I use `n` in front of the clause.
My prefered implemention uses guard clauses for few reason, first it feels more functional reflecting the paradigm, the second is as it uses pattern matching is easy to maintain and uses the elixir/erlang power.


## Guard Clause

```
defmodule FizzBuzz do
  def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

  defp fizzbuzz(n), do: _fizzword(n, rem(n, 3), rem(n, 5))
  defp _fizzword(_n, 0, 0), do: "FizzBuzz"
  defp _fizzword(_n, 0, _), do: "Fizz"
  defp _fizzword(_n, _, 0), do: "Buzz"
  defp _fizzword( n, _, _), do: n
end
```

## Using `cond`


```
defmodule FizzBuzz do
  def upto(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do cond do
    rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
    rem(n, 3) == 0 ->
      "Fizz"
    rem(n, 5) == 0 ->
      "Buzz"
    true -> n
  end end
end
```

## Using `case`

```
defmodule ControlFlow do
  def up_to(n) do
    Enum.map(1..n, &fizzbuzz/1)
  end

  def fizzbuzz(n) do
    case n do
      n when rem(n, 5) == 0 and rem(n, 3) == 0 ->
        "FizzBuzz"
      n when rem(n,3) == 0 ->
        "Fizz"
      n when rem(n, 5) == 0 ->
        "Buzz"
      n ->
        n
    end
  end
end
```
