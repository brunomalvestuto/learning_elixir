defmodule StringsAndBinaries do
  Code.load_file("../list_and_recursion/exercise_8.exs")

  def parse_and_apply_tax(path) do
    file = File.open!(path)
    headers = parse_header(IO.read(file, :line))
    orders = Enum.map(IO.stream(file, :line), &parse_row(headers, &1))
    ApplyTax.to orders, [ NC: 0.075, TX: 0.08 ]
  end

  def parse_header(string) do
    string |>
    String.strip |>
    String.split(",") |>
    Enum.map(&String.to_atom/1)
  end

  defp parse_row(header, row) do
    values = row |>
    String.strip |>
    String.split(",") |>
    Enum.map(&convert_to/1)

    Enum.zip(header, values)
  end

  defp convert_to(value) do
    cond do
      Regex.match?(~r{^\d+$}, value) -> String.to_integer(value)
      Regex.match?(~r{^\d+\.\d+$}, value) -> String.to_float(value)
      << ?: :: utf8, name :: binary>> = value -> String.to_atom(name)
      true -> value
    end
  end
end


# StringsAndBinaries.parse_and_apply_tax("order.csv")
