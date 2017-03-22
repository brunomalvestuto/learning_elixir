defmodule MultipleProcesses do
  def read_message() do
    receive do
      token ->
        IO.puts("Message Received: #{inspect token}")
        read_message()
      after 500 ->
        IO.puts("No more messages")
    end
  end

  def child(parent, end_strategy) do
    send(parent, "Message to parent from child")
    end_strategy.("boom")
  end
end
