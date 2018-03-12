# Rework your stack server to use a supervision tree with a separate stash process to hold the state. Verify that it works and that when you crash the server the state is retained across a restart.

defmodule Stack.Server do
  use GenServer
  def start_link(_), do: GenServer.start_link(__MODULE__, nil , name: __MODULE__)

  def pop, do: GenServer.call(__MODULE__, :pop)
  def push(elem), do: GenServer.cast(__MODULE__, {:push, elem})

  def shutdown, do: GenServer.cast(__MODULE__, :shutdown)

  def init(_), do: {:ok, Stack.Stash.get() }
  def handle_call(:pop, _from, [ head |rest ]), do: { :reply, head, rest}
  def handle_call(:pop, _from, []), do: { :stop, "Cannot pop from an empty stack", []}
  def handle_cast(:shutdown, stack), do: { :stop, "shutdown message has been sent to the server", stack }
  def handle_cast({:push, element}, stack), do: { :noreply, [element | stack] }

  def terminate(reason, state) do
    IO.inspect Stack.Stash.set(state)
    IO.puts("Stack server terminating due to #{inspect reason} state: #{inspect state}")
    :ok
  end
end

defmodule Stack.Stash do
  use GenServer

  def start_link(initial_value), do: GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  def get, do: GenServer.call(__MODULE__, :get)
  def set(value), do: GenServer.cast(__MODULE__, {:set, value})

  def init(initial_value), do: {:ok, initial_value}
  def handle_call(:get, _from, state), do: {:reply, state, state}
  def handle_cast({:set, value}, _state), do: {:noreply, value}

end

defmodule Stack.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Stack.Stash, [1,2,3] },
      {Stack.Server, nil }
    ]
    opts = [strategy: :rest_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# iex(1)> Stack.Application.start(nil,nil)
# iex(2)> Stack.Server.push(147)
# iex(3)> Stack.Server.shutdown
# iex(4)> Stack.Server.shutdown
