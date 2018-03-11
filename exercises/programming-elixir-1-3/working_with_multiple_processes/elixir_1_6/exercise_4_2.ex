defmodule SendAndRun do
  import :timer, only: [sleep: 1]
  def send_and_run(parent_pid) do
    send parent_pid, { :ok, "I'm gonna exist! OUT!!" }
    raise("I'm out")
  end

  def run do
    spawn_monitor(SendAndRun, :send_and_run, [self()])
    sleep 500
    receive_msg()
  end

  def receive_msg do
    receive do
      msg ->
        IO.inspect msg
        receive_msg()
      after 500 ->
          IO.inspect "Exiting, no more messages."
    end
  end
end


# elixir -r exercise_4_2.ex -e "SendAndRun.run"
# The raise makes the tracing output more useful information about the exit like the line where it existed
