# The ticker process in this chapter is a central server that sends events to registered clients.
# Reimplement this as a ring of clients. A client sends a tick to the next client in the ring. After 2 seconds, that client sends a tick to its next client.
# When thinking about how to add clients to the ring, remember to deal with the case where a client’s receive loop times out just as you’re adding a new process. What does this say about who has to be responsible for updating the links?

defmodule Ring do
  @name :master_node

  def start do
    new_pid = spawn(__MODULE__, :loop, [])

    case :global.whereis_name(@name) do
      :undefined ->
        IO.puts "Creating the first process"
        new_pid
        |> register_as_master_node
        |> send({ :tick })
      pid ->
        IO.puts "Sending :register to master node #{inspect pid}"
        send pid, { :register, new_pid}
    end
  end

  def loop(next \\ self()) do
    receive do
      { :update_link, pid } ->
        loop(pid)
      { :register, pid } ->
        pid
        |> update_link(next: next)
        |> register_as_master_node
        |> loop
      { :tick } ->
        IO.puts "tock in client  #{inspect self()} next to tick #{inspect next}"
        Process.sleep 2000
        send next, { :tick }
        loop(next)
    end
  end

  defp register_as_master_node(pid) do
    IO.puts "Registering #{inspect pid} as the master node"
    :global.re_register_name(@name, pid )
    pid
  end

  defp update_link(pid, next: next_pid) do
    send pid, { :update_link, next_pid }
    pid
  end
end
