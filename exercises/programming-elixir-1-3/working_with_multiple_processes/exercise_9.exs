Code.load_file("scheduler.exs")
Code.load_file("word_counter.exs")

to_process = File.ls!("#{System.cwd()}/dir_with_cats")
             |> Enum.map(fn(file) -> "#{System.cwd()}/dir_with_cats/#{file}" end)

Enum.each 1..10, fn num_processes ->
  { time, result } = :timer.tc(Scheduler, :run, [num_processes, CatCounterServer, :count, to_process])
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end
  :io.format "~2B ~.2f~n", [num_processes, time/1000000.0]
end

exit(:normal)
