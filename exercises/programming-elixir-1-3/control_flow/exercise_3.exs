defmodule ControlFlow do
  def ok!({:ok, data}), do: data
  def ok!({:error, message}), do: raise "Failed with: #{message}"
end
