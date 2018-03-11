defmodule SendAndRun do
  import :timer, only: [sleep: 1]
  def send_and_run(parent_pid) do
    send parent_pid, { :ok, "I'm gonna exist! OUT!!" }
    exit(:out)
  end

  def run do
    spawn_link(SendAndRun, :send_and_run, [self()])
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


# elixir -r exercise_3.ex -e "SendAndRun.run"
#
# Does it matter that you weren’t waiting for the notification from the child when it exited?
# It does matter 'cause by the time I start to receive messages the child process had existed causing the parent to exist.
