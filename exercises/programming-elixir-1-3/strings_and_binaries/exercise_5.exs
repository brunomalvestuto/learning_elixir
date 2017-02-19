defmodule StringsAndBinaries do
  def center(list) do
    ordered_list = Enum.sort_by(list, &String.length/1, &>=/2)
    [ longest_width | _ ] = ordered_list
    longest_width = String.length(longest_width)
    ordered_list |> Enum.reverse |> Enum.each(fn(word) ->
      offset = round(div(longest_width,2) - Float.ceil(String.length(word) / 2))
      IO.puts("#{String.pad_leading("", offset)}#{word}") end)
  end
end

# StringsAndBinaries.center(["cat", "zebra", "elephant"])
