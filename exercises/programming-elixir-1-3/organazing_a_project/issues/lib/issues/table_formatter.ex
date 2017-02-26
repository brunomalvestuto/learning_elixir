defmodule Issues.TableFormatter do
  def print_table_for_columns(list, headers) do
    with splited_into_columns <- split_into_columns(list, headers),
         columns_width <- widths_of(splited_into_columns),
         format <- format_for(columns_width)
         do
           :io.format(format, headers)
           puts_separator(columns_width)
           splited_into_columns |> Enum.zip |>
                  Enum.each(fn(row) -> :io.format(format, Tuple.to_list(row)) end)
         end
  end

  def split_into_columns(data, headers) do
    for header <- headers do
      for row <- data, do: printable(row[header])
    end
  end

  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  def puts_separator(columns_width) do
    columns_width |>
      Enum.map(fn(size) -> String.pad_leading("", size, "-") end) |>
      Enum.join("-+-") |> IO.puts
  end

  def format_for(columns_width) do
    result = columns_width |>
      Enum.map(fn(width) -> "~-#{width}s"end) |>
      Enum.join(" | ")
    "#{result}~n"
  end

  def widths_of(data_column_spilted) do
    for column_data <-  data_column_spilted,
      do: Enum.max_by(column_data, &String.length/1) |> String.length
  end
end
