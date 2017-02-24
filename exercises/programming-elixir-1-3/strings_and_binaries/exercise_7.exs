defmodule StringsAndBinaries do
  Code.load_file("../list_and_recursion/exercise_8.exs")

  import String, only: [to_atom: 1, to_integer: 1, to_float: 1]

  def parse_and_apply_tax(path) do
    orders = File.stream!(path) |>
      Stream.drop(1) |> # header
      Stream.map(&(String.split(String.trim(&1), ","))) |>
      Stream.map(&parse_row/1) |>
      Enum.to_list

    ApplyTax.to orders, [ NC: 0.075, TX: 0.08 ]
  end

  defp parse_row([id,ship_to, net_amount]) do
    [{:id, to_integer(id)},
     {:ship_to, to_atom(String.trim_leading(ship_to, ":"))},
     {:net_amount, to_float(net_amount)}]
  end
end
