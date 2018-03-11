# Alter the code so that successive ticks are sent to each registered client (so the first goes to the first client,
# the second to the next client, and so on). Once the last client receives a tick, the process starts back at the first.
# The solution should deal with new clients being added at any time.

defmodule Ticker do

  @interval 2000   # 2 seconds
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [{[], 0}])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(state = {clients, index} ) do
    receive do
      { :register, pid } ->
        IO.puts "Registering #{inspect pid}"
        generator({ List.insert_at(clients, -1, pid), index})
    after
      @interval ->
        generator(send_to_next(state))
    end
  end

  defp send_to_next(state = {[], _ }), do: state
  defp send_to_next(state = {clients, index}) do
    pid = Enum.at(clients, index)
    IO.puts "Sending tick to #{inspect pid}, index: #{index}"
    send pid, { :tick }
    {clients, next_position(state)}
  end

  defp next_position({clients, index}) when (index + 1) >= length(clients),  do: 0
  defp next_position({_, index}), do: index + 1

end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver()
    end
  end
end
