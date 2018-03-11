defmodule WordCounter do
  def count(file_path, word) do
    File.read!(file_path)
      |> String.split()
      |> Enum.reduce(0, fn(elm, acc) ->
        case elm do
          ^word ->
            acc + 1
          _ ->
            acc
        end
      end)
  end
end

defmodule CatCounterServer do
  def count(scheduler) do
    IO.puts "#{inspect self()} wait for work"
    send scheduler, {:ready, self()}

    receive do
      { :job, file, client } ->
        IO.puts "#{inspect self()} start doing work"
        count = WordCounter.count(file, "cat")
        send client, { :answer, "", count, self()  }
        count(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end
end
