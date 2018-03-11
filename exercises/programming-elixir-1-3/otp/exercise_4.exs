# Add the API to your stack module (the functions that wrap the GenServer calls).

defmodule Stack do
  use GenServer
  def start_link(stack), do: GenServer.start_link(__MODULE__, stack, name: __MODULE__)

  def pop, do: GenServer.call(__MODULE__, :pop)
  def push(elem), do: GenServer.cast(__MODULE__, {:push, elem})

  def init(stack), do: {:ok, stack}
  def handle_call(:pop, _from, [ head |rest ]), do: { :reply, head, rest}
  def handle_cast({:push, element}, stack), do: { :noreply, [element | stack] }
end
