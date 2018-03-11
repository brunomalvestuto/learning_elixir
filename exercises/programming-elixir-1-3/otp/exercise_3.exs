# Give your stack server process a name, and make sure it is accessible by that name in iex.
#
defmodule Stack do
  use GenServer
  def start_link(stack), do: GenServer.start_link(__MODULE__, stack, name: __MODULE__)

  def init(stack), do: {:ok, stack}
  def handle_call(:pop, _from, [ head |rest ]), do: { :reply, head, rest}
  def handle_cast({:push, element}, stack), do: { :noreply, [element | stack] }
end
