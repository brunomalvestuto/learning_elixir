# Add a supervisor to your stack application. Use iex to make sure it starts the server correctly. Use the server normally, and then crash it (try popping from an empty stack). Did it restart? What were the stack contents after the restart

defmodule Stack.Server do
  use GenServer
  def start_link(stack), do: GenServer.start_link(__MODULE__, stack, name: __MODULE__)

  def pop, do: GenServer.call(__MODULE__, :pop)
  def push(elem), do: GenServer.cast(__MODULE__, {:push, elem})

  def shutdown, do: GenServer.cast(__MODULE__, :shutdown)

  def init(stack), do: {:ok, stack}
  def handle_call(:pop, _from, [ head |rest ]), do: { :reply, head, rest}
  def handle_call(:pop, _from, []), do: { :stop, "Cannot pop from an empty stack", []}
  def handle_cast(:shutdown, stack), do: { :stop, "shutdown message has been sent to the server", stack }
  def handle_cast({:push, element}, stack), do: { :noreply, [element | stack] }

  def terminate(reason, state) do
    IO.puts("Stack server terminating due to #{inspect reason} state: #{inspect state}")
    :ok
  end
end

defmodule Stack.Application do
  use Application

  def start(_type, _args) do
    children = [{Stack.Server, [1,2,3] }]
    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

# iex(1)> Stack.Application.start(nil,nil)
# iex(2)> Stack.server.pop
