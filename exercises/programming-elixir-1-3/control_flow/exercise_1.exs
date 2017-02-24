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
