defmodule Scheduler do

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes) |>
      Enum.map(fn(_) -> spawn(module, func, [self()]) end) |>
      schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, {:job, next, self()}
        schedule_processes(processes, tail, results)
      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn n1, n2 -> n1 <= n2 end) |> Enum.reduce(&(&1 + &2))
        end
      {:answer, _, result, _pid} ->
        schedule_processes(processes, queue, [ result | results ])
    end
  end
end
