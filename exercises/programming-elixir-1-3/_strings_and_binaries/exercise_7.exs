defmodule StringsAndBinaries do
  Code.load_file("../list_and_recursion/exercise_8.exs")
  def parse_and_apply_tax(file) do
    File.open!(file) |> IO.stream
    IO.stream(file, :file)
    _parse()

    ApplyTax.to(orders, [ NC: 0.075, TX: 0.08 ])
  end

  defp _parse()
end

# StringsAndBinaries.parse_and_apply_tax("sales.csv")
