defmodule WordCounter do
  def count(file_path, word) do
    count = File.read!(file_path) |>
      String.split() |>
      Enum.reduce([], fn(word, acc) ->
        Keyword.put(acc, String.to_atom(word), Keyword.get(acc, String.to_atom(word), 0) + 1)
      end) |>
       Keyword.get(String.to_atom(word), 0)

      { word, count}
  end
end

defmodule CatCounterServer do
  def count(scheduler) do
    send scheduler, {:ready, self()}

    receive do
      { :job, file, client } ->
        { _, count} = WordCounter.count(file, "cat")
        send client, { :answer, file, count, self()  }
        count(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end
end
