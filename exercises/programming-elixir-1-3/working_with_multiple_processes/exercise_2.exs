defmodule PingPong do
  def pingpong(send_to) do
    receive do
      token ->
        send send_to, token
    end
  end

  def run() do
    p1 = spawn(PingPong, :pingpong, [self()])
    p2 = spawn(PingPong, :pingpong, [self()])

    send p1, "Fred"
    send p2, "Betty"
    wait()
  end

  def wait() do
    receive do
      token ->
        IO.inspect(token)
        wait()
      after 500 ->
        IO.puts "it's gone"
    end
  end
end
