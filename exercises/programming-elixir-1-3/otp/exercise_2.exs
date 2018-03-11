# Extend your stack server with a push interface that adds a single value to the top of the stack. This will be implemented as a cast.
# Experiment in iex with pushing and popping values.

defmodule Stack do
  use GenServer
  def init(stack), do: {:ok, stack}
  def handle_call(:pop, _from, [ head |rest ]), do: { :reply, head, rest}
  def handle_cast({:push, element}, stack), do: { :noreply, [element | stack] }
end
