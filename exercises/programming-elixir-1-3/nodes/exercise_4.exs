# The ticker process in this chapter is a central server that sends events to registered clients.
# Reimplement this as a ring of clients. A client sends a tick to the next client in the ring. After 2 seconds, that client sends a tick to its next client.
# When thinking about how to add clients to the ring, remember to deal with the case where a client’s receive loop times out just as you’re adding a new process. What does this say about who has to be responsible for updating the links?

defmodule Ticker do
  @name :server

  def start do
    pid = spawn(__MODULE__, :ring, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def ring(clients) do
    receive do
      { :register, pid } ->
        send pid, {:next, List.last(clients) || pid }

        if List.first(clients) do
          send List.first(clients), { :next, pid }
        end

        clients = [ pid | clients ]

        if length(clients) == 1, do: send pid, {:tick}

        IO.puts "Ring: #{inspect clients}"
        ring(clients)
    end
  end

end

defmodule Client do

  def start() do
    pid = spawn(__MODULE__, :receiver, [self()])
    Ticker.register(pid)
  end


  def receiver(next_client) do
    receive do
      { :next, next_client } ->
        receiver(next_client)
      { :tick } ->
        IO.puts "tock in client  #{inspect self()} next to tick #{inspect next_client}"
        Process.sleep 2000
        send next_client, { :tick }

        receiver(next_client)
    end
  end
end

