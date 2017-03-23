# given a name and a number create a dir and create and a number of files inside the directory population them with a random amount of words
defmodule DirWithCats do
  def run(name, number_of_files) do
    dir_path = "#{System.cwd()}/#{name}"
    File.mkdir! dir_path

    Enum.map(1..number_of_files, fn(n) ->
      spawn(DirWithCats, :create_file, [dir_path, "#{n}.txt", self()])
    end) |> Enum.each(fn(pid) ->
      receive do
        {^pid, :completed} ->
          IO.puts("PID: #{inspect pid} completed")
      end
    end)
    :ok
  end

  def create_file(dir_path, name, parent) do
    list_of_words = ~w(ps4 cat game haduken mac computer pc monitor banana mug wallet cable chat hangout)
    text = Enum.map(1..:rand.uniform(50), fn(_) ->
      Enum.random(list_of_words)
    end) |> Enum.join(" ")

    File.write! "#{dir_path}/#{name}", text
    send parent, {self(), :completed}
  end
end

DirWithCats.run("dir_with_cats", 50_000)
exit(:normal)
