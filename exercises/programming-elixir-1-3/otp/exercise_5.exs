# Implement the terminate callback in your stack handler. Use IO.puts to report the arguments it receives.
# Try various ways of terminating your server. For example, popping an empty stack will raise an exception. You might add code that calls System.halt(n) if the push handler receives a number less than 10. (This will let you generate different return codes.) Use your imagination to try differ- ent scenarios.

defmodule Stack do
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

# iex(1)> Stack.start_link([])
# iex(2)> Stack.pop

# This kill the process before it has time to terminate
# iex(1)> Stack.start_link([1,2])
# iex(2)> Process.exit(GenServer.whereis(Stack), "the process was killed intentionally")
#
