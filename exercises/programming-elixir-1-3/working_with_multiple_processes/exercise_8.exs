Code.load_file("scheduler.exs")
Code.load_file("fib_solver.exs")

to_process = List.duplicate(37, 20)

Enum.each 1..10, fn num_processes ->
  { time, result } = :timer.tc(Scheduler, :run, [num_processes, FibSolver, :fib, to_process])
  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end
  :io.format "~2B ~.2f~n", [num_processes, time/1000000.0]
end
exit(:normal)

"""
3.1 GHz Intel Core i7
# time (s)
01 22.30
02 11.07
03 10.41
04 10.31
05 10.46
06 10.68
07 10.59
08 10.09
09 9.75
10 9.88
"""
