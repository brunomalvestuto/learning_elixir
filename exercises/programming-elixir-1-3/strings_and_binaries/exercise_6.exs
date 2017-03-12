defmodule StringsAndBinaries do
  def capitalize_sentence(dqs) do
    dqs |> String.split(". ") |> Enum.map_join(". ", &String.capitalize/1)
  end
end

# StringsAndBinaries.capitalize_sentence("oh. a DOG. woof. ")
